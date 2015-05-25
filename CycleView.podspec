#
# Be sure to run `pod lib lint CycleView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CycleView"
  s.version          = “1.0.1”
  s.summary          = "The view of an infinite loop.一个无线循环的图片轮播器"
  s.description      = <<-DESC
                       An optional longer description of CycleView

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/SarielTang/CycleView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "SarielTang" => "524896762@qq.com" }
  s.source           = { :git => "https://github.com/SarielTang/CycleView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/CycleView/Source/*.swift'
  # s.resource_bundles = {
  #   'CycleView' => ['Pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
