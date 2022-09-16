Pod::Spec.new do |s|
  s.name      = 'MobileAnalyticsChartSwift'
  s.version   = '1.3.1'
  s.homepage  = 'https://git.yoomoney.ru/projects/SDK/repos/mobile-analytics-chart-swift'
  s.license   = {
    :type => "MIT",
    :file => "LICENSE"
  }
  s.authors = 'YooMoney'
  s.summary = 'Mobile Analytics Chart'

  s.source = { :git => "https://git.yoomoney.ru/scm/sdk/mobile-analytics-chart-swift.git", :tag => "1.3.1" }
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.ios.source_files  = 'MobileAnalyticsChartSwift/**/*.{h,swift}', 'MobileAnalyticsChartSwift/*.{h,swift}'

  s.ios.framework  = 'UIKit'
end