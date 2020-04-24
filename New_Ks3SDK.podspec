Pod::Spec.new do |s|

  s.name         = "New_Ks3SDK"
  s.version      = "1.0.0"
  s.summary      = "iOS SDK for Kingsoft Standard Storage Service"

  s.description  = <<-DESC
    An iOS SDK for developers to use Kingsoft Standard Storage Service easier.
                   DESC

  s.homepage     = "https://github.com/ks3sdk/new_Ks3Sdk_ios"

  s.license      = "Apache License, Version 2.0"

  s.author       = { "cqc" => "cqclife@qq.com" }

  s.source       = { :git => "https://github.com/ks3sdk/new_Ks3Sdk_ios.git", :tag => "v#{s.version}" }

  s.requires_arc = true

  s.ios.deployment_target = '7.0'

  s.source_files  = "KS3YunSDK/**/*.{h,m}"
end
