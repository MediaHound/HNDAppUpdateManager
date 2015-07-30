Pod::Spec.new do |s|
  s.name             = "HNDAppUpdateManager"
  s.version          = "0.0.2"
  s.summary          = "HNDAppUpdateManager"
  s.homepage         = ""
  s.license          = 'MIT'
  s.author           = { "Dustin Bachrach" => "dustin@mediahound.com" }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = "Classes/**/*.{h,m}"

  s.dependency 'AFNetworking'
  s.dependency 'AgnosticLogger'
  s.dependency 'Avenue'
end
