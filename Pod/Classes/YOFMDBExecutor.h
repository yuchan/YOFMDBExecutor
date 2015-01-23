//
//  YOFMDBExecutor.h
//
//  Created by Yusuke Ohashi on 1/23/15.
//  Copyright (c) 2015 Ohashi Yusuke. All rights reserved.
//

#import <FMDB.h>

@interface YOFMDBExecutor : NSObject
@property (nonatomic, readonly) FMDatabase *db;
/**
 * gets singleton object.
 * @return singleton
 */
+ (YOFMDBExecutor *)sharedInstance;
- (void)setup:(NSString *)dbname;

/**
 *  execution
 *
 *  @param block callback
 */
- (void)exec:(void (^)(FMDatabase *db))block;

@end
