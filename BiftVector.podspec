#
# Be sure to run `pod lib lint BiftVector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BiftVector"
  s.version          = "0.1.0"
  s.summary          = "Swift bit array library"

  s.description      = <<-DESC
                       This library provides bit vector objects and functions.

                       See the project on GitHub.

                       DESC

  s.homepage         = "https://github.com/idcrook/BiftVector"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "David Crook"
  s.source           = { :git => "https://github.com/idcrook/BiftVector.git", :tag => "v#{s.version}" }
  # s.social_media_url = 'https://twitter.com/idcrook'
  s.social_media_url = ''

  # #s.osx.deployment_target = '10.10'
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.11"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  # s.source_files = 'Sources/*.{swift,h}'
  s.source_files  = "Sources/**/*.swift"
  s.frameworks  = "Foundation"

end