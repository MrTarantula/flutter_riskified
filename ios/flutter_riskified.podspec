#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_riskified.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_riskified'
  s.version          = '0.1.0'
  s.summary          = 'Riskified plugin for Flutter.'
  s.description      = <<-DESC
Riskified plugin for Flutter.
                       DESC
  s.homepage         = 'https://github.com/MrTarantula/flutter_risified'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Ryan Tauriainen' => 'ryan@ryant.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  s.dependency 'RiskifiedBeacon', '~>1.2.7'
end
