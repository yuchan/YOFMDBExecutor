#
# Be sure to run `pod lib lint YOFMDBExecutor.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YOFMDBExecutor"
  s.version          = "0.1.0"
  s.summary          = "Deadly Simple FMDB Executor."
  s.description      = <<-DESC
                       Deadly Simple FMDB Executor.
                       No clutter open & close methods.
                       DESC
  s.homepage         = "https://github.com/yuchan/YOFMDBExecutor"
  s.license          = 'MIT'
  s.author           = { "yuchan" => "yusuke@junkpiano.me" }
  s.source           = { :git => "https://github.com/yuchan/YOFMDBExecutor.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'YOFMDBExecutor' => ['Pod/Assets/*.png']
  }
  s.dependency 'FMDB', '~> 2.4'
end
