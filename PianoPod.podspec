Pod::Spec.new do |s|
  s.name             = 'PianoPod'
  s.version          = '0.1.0'
  s.summary          = 'A customizable piano keyboard'

  s.description      = <<-DESC
  PianoPod provides a customizable piano keyboard for use in iOS applications.
                       DESC

  s.homepage         = 'https://github.com/trothrock/PianoPod'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'theodore.rothrock@gmail.com' => 'theodore.rothrock@gmail.com' }
  s.source           = { :git => 'https://github.com/trothrock/PianoPod.git', :tag => s.version.to_s }
  s.swift_version    = '4.0'

  s.ios.deployment_target = '13.0'

  s.source_files = 'PianoPod/Classes/**/*'
  s.ios.resource_bundle = { 'PianoPod' => 'PianoPod/Assets/Audio/*.mp3' }

end
