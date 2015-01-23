//
//  YOFMDBExecutor.m
//
//  Created by Yusuke Ohashi on 1/23/15.
//  Copyright (c) 2015 Ohashi Yusuke. All rights reserved.
//

#import "YOFMDBExecutor.h"

@implementation YOFMDBExecutor
@synthesize db = _db;

static YOFMDBExecutor *SINGLETON = nil;
static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    isFirstAccess = NO;
	    SINGLETON = [[super allocWithZone:NULL] init];
	});

	return SINGLETON;
}

#pragma mark - Life Cycle

+ (id)allocWithZone:(NSZone *)zone {
	return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone {
	return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone {
	return [self sharedInstance];
}

- (id)copy {
	return [[YOFMDBExecutor alloc] init];
}

- (id)mutableCopy {
	return [[YOFMDBExecutor alloc] init];
}

- (id)init {
	if (SINGLETON) {
		return SINGLETON;
	}
	if (isFirstAccess) {
		[self doesNotRecognizeSelector:_cmd];
	}
	self = [super init];
	return self;
}

/**
 *  Create Database if it doesn't exist.
 *
 *  @param dbname database name.
 */
- (void)setup:(NSString *)dbname {
	BOOL success;

	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentDir stringByAppendingPathComponent:dbname];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:databasePath];

	if (!success) {
		NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbname];
		[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	}

	_db = [FMDatabase databaseWithPath:databasePath];
}

- (void)exec:(void (^)(FMDatabase *db))block;
{
	if ([self.db open]) {
		if (block) {
			block(self.db);
		}
		[self.db close];
	}
}

@end
