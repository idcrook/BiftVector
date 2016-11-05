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
                       DESC

  s.homepage         = "https://github.com/idcrook/BiftVector"
  s.license          = { :type => "MIT", :file => "LICENSE.txt" }
  s.author           = "David Crook"
  s.source           = { :git => "https://github.com/idcrook/BiftVector.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/idcrook'

  s.ios.deployment_target = '8.0'
  #s.osx.deployment_target = '10.10'

  s.source_files = 'Sources/*.{swift,h}'
end

