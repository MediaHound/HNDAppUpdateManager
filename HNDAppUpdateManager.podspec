Pod::Spec.new do |s|
  s.name             = "HNDAppUpdateManager"
  s.version          = "0.1.0"
  s.summary          = "HNDAppUpdateManager"
  s.homepage         = "https://github.com/MediaHound/HNDAppUpdateManager"
  s.license          = 'Apache'
  s.author           = { "Dustin Bachrach" => "dustin@mediahound.com" }
  s.source           = { :git => "https://github.com/MediaHound/HNDAppUpdateManager.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = "Classes/**/*.{h,m}"

  s.dependency 'AFNetworking'
  s.dependency 'Avenue'
end
