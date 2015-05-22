Pod::Spec.new do |s|
  s.name         = "CycleView"
  s.version      = "1.0.0"
  s.summary      = "Simple QRCode detector and generator in Swift"
  s.homepage     = "https://github.com/SarielTang/CycleView"
  s.license      = "MIT"
  s.author             = { "Sariel Tang" => "524896762@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/SarielTang/CycleView.git", :tag => s.version }
  s.source_files  = "CycleView/Source/*.swift"
  s.requires_arc = true
end
