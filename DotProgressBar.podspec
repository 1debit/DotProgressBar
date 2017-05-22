Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "DotProgressBar"
  s.summary = "DotProgressBar is an animatable progress bar for chunks of work specified by dots."
  s.requires_arc = true

  s.version = "0.1.0"

  s.license = { :type => "MIT", :file => "LICENSE" }

  s.author = { "Rob Norback" => "rnorback@gmail.com" }

  s.homepage = "https://github.com/1debit/DotProgressBar"

  s.source = { :git => "https://github.com/1debit/DotProgressBar.git", :tag => "#{s.version}"}

  s.framework = "UIKit"
  
  s.source_files = "DotProgressBar/**/*.{swift}"

  s.resources = "DotProgressBar/**/*.{storyboard,xib}"
end
