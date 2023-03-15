#
# Be sure to run `pod lib lint Smpl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Smpl'
  s.version          = '0.1.4'
  s.summary          = 'Smpl is an omnichannel marketing automation tool'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: You can integrate Smpl to your app with this library. You can use the documentation to learn how to use the library.
                       DESC

  s.homepage         = 'https://github.com/techsmpl/smpl-swift-lib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cangokceaslan' => '48398625+cangokceaslan@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/techsmpl/smpl-swift-lib.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/cangokceaslan'

  s.documentation_url = 'https://www.github.com/techsmpl/smpl-swift-lib'

  s.ios.deployment_target = '13.0'

  s.source_files = 'Smpl/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Smpl' => ['Smpl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'Alamofire', '~> 5.6.3'
  s.dependency 'Alamofire', '~> 5.6.3'
  s.dependency 'ReSwift', '~> 6.1.1'
	s.dependency 'Firebase', '~>10.6.0'
	s.dependency 'Firebase/Core', '~>10.6.0'
	s.dependency 'Firebase/Messaging', '~>10.6.0'
end
