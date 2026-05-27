#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint torch_light.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'torch_light'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin to check if the device has a torch and to turn it on and off.'
  s.description      = <<-DESC
torch_light is a Flutter plugin that lets you check whether the device has a torch (flashlight)
and turn it on or off via AVFoundation on iOS.
                       DESC
  s.homepage         = 'https://davidserrano.io/'
  s.license          = { :type => 'Apache-2.0', :file => '../LICENSE' }
  s.author           = { 'David Serrano Canales' => 'contact@davidserrano.io' }
  s.source           = { :git => 'https://github.com/svprdga/torch_light.git', :tag => s.version.to_s }
  s.source_files = 'torch_light/Sources/torch_light/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
