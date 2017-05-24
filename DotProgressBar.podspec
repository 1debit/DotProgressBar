Pod::Spec.new do |s|
  s.name          = "DotProgressBar"
  s.summary       = "DotProgressBar is an animatable progress bar for chunks of work specified by dots."
  s.version       = "0.6.2"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.authors       = { "Rob Norback" => "rnorback@gmail.com", "Eric Lewis" => "eric@chimebank.com" }
  s.homepage      = "https://github.com/1debit/DotProgressBar"
  s.source        = { :git => "https://github.com/1debit/DotProgressBar.git", :tag => "#{s.version}"}
  s.source_files  = "DotProgressBar/**/*.{swift}"
  s.framework     = "UIKit"

  s.platform              = :ios
  s.ios.deployment_target = '9.0'
end
