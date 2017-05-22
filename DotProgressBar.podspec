Pod::Spec.new do |spec|
  spec.name = "DotProgressBar"
  spec.summary = "DotProgressBar is an animatable progress bar for chunks of work specified by dots."
  spec.version = "0.3.1"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.authors = { "Rob Norback" => "rnorback@gmail.com" }
  spec.homepage = "https://github.com/1debit/DotProgressBar"
  spec.source = { :git => "https://github.com/1debit/DotProgressBar.git", :tag => "#{spec.version}"}

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  spec.framework = "UIKit"
  spec.source_files = "DotProgressBar/**/*.{swift}"
end
