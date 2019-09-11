Pod::Spec.new do |spec|
  spec.name         = "WSCoreText"
  spec.version      = "0.0.1"
  spec.summary      = "WSCoreText."
  spec.description  = <<-DESC
WSCoreText is order to slove rich text display
                   DESC

  spec.homepage     = "http://EXAMPLE/WSCoreText"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Will" => "1229820171@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/WSSunShine/WSCoreText.git", :tag => "#{spec.version}" }
  spec.source_files  = "WSCoreText/CoreText/*.{h,m}"
  spec.public_header_files = "WSCoreText/CoreText/*.h"
  spec.requires_arc = true
end