#
# Be sure to run `pod lib lint XLEasyKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "XLEasyKit"
  s.version          = "0.1.0"
  s.summary          = "提供基于UIKit的基础库"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                实现TableView、SearchController、TextView、Label等基础类
                       DESC

  s.homepage         = "https://github.com/randyeasy/XLEasyKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Randy" => "ouyaliang@163.com" }
  s.source           = { :git => "https://github.com/randyeasy/XLEasyKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'XLEasyKit' => ['Pod/Assets/*.png', 'Pod/Assets/*.gif']
  }


  s.prefix_header_contents =
    '#import "XLEApperance.h"',
    '#import <SDWebImage/UIButton+WebCache.h>',
    '#import <XLEasyFoundation/XLEasyFoundation.h>',
    '#import <PureLayout/PureLayout.h>',
    '#import <MBProgressHUD/MBProgressHUD.h>',
    '#import <XLEasyCache/XLEasyCache.h>',
    '#import <XLEasyKitUtils/XLEasyKitUtils.h>'

  s.frameworks = 'UIKit'
  s.dependency 'PureLayout', '~> 3.0.1'
  s.dependency 'SDWebImage', '~> 3.7.0'
  s.dependency 'MJRefresh', '~> 3.1'
  s.dependency 'XLEasyFoundation', '~> 0.1.0'
  s.dependency 'XLEasyKitUtils', '~> 0.1'
  s.dependency 'JSBadgeView', '~> 1.4.1'
  s.dependency 'MBProgressHUD', '~> 0.9'
  s.dependency 'YLGIFImage', '~> 0.11'
  s.dependency 'XLEasyCache', '~> 0.1.0'

end
