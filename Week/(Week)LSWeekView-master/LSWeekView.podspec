Pod::Spec.new do |s|
  s.name             = "LSWeekView"
  s.version          = '1.0.5'
  s.summary          = "iOS week view control, similar to the one used in the iOS 7 Calendar app (day view)."
  s.description      = <<-DESC
A scrollable week view that allows the user to select a date. Designed for iOS 7 and 8. See the screenshot.
                       DESC
  s.homepage         = "https://github.com/LumenSpark/LSWeekView"
  s.screenshots      = "https://github.com/LumenSpark/LSWeekView/raw/master/Screenshot.png"
  s.license          = 'MIT'
  s.author           = { "Christoph Zelazowski" => "chrisze@lumenspark.com" }
  s.source           = { :git => "https://github.com/LumenSpark/LSWeekView.git", :tag => '1.0.5' }

  s.platform         = :ios, '7.0'
  s.requires_arc     = true

  s.source_files = 'Classes'
end
