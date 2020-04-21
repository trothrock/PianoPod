Pod::Spec.new do |s|
  s.name             = 'PianoPod'
  s.version          = '0.1.0'
  s.summary          = 'A customizable piano keyboard'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  PianoPod provides a customizable piano keyboard for use in iOS applications.
                       DESC

  s.homepage         = 'https://github.com/theodore.rothrock@gmail.com/PianoPod'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'theodore.rothrock@gmail.com' => 'theodore.rothrock@gmail.com' }
  s.source           = { :git => 'https://github.com/trothrock/PianoPod.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'PianoPod/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PianoPod' => ['PianoPod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
