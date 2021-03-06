#
# Be sure to run `pod lib lint FastBlurView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FastBlurView'
  s.version          = '0.1.0'
  s.summary          = 'A simple swift library for blurring view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  FastBlurView is a pure swift library for blurring view.
  It is based on Metal, implemented simplely.
                       DESC

  s.homepage         = 'https://github.com/cleexiang/FastBlurView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cleexiang' => 'cleexiang@126.com' }
  s.source           = { :git => 'https://github.com/cleexiang/FastBlurView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'FastBlurView/Classes/**/*'
end
