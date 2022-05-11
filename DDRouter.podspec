Pod::Spec.new do |spec|
  spec.name         = 'DDRouter'
  spec.version      = '0.7.0'
  spec.license      = { :type => 'ISC' }
  spec.homepage     = 'https://github.com/DeloitteDigitalAPAC/ddrouter'
  spec.authors      = { 'Deloitte Digital' => 'tplester@deloitte.com.au' }
  spec.summary      = 'Deloitte Digital simple networking framework.'
  spec.source       = { :git => 'https://github.com/DeloitteDigitalAPAC/ddrouter.git', :tag => 'v0.7.0' }
  spec.source_files = 'DDRouter', 'DDRouter/**/*.swift'
  spec.framework    = 'RxSwift'
  spec.platform     = :ios, "11.0"
  spec.swift_version = '5'
  spec.dependency 'RxSwift', '~> 6.0'
  spec.static_framework = true
end
