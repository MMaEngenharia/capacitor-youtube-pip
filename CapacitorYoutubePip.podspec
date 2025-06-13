Pod::Spec.new do |s|
  s.name             = 'CapacitorYoutubePip'
  s.version          = '0.0.1'
  s.summary          = 'Capacitor plugin para Picture-in-Picture com YouTube'
  s.license          = 'MIT'
  s.homepage         = 'https://github.com/MMaEngenharia/capacitor-youtube-pip'
  s.author           = { 'Seu Nome' => 'seu@email.com' }
  s.source           = { :git => 'https://github.com/MMaEngenharia/capacitor-youtube-pip.git', :tag => s.version.to_s }
  s.source_files     = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
  s.platform         = :ios, '15.0'
  s.requires_arc     = true
  s.dependency       'Capacitor', '>= 7.0.0'
  s.swift_version = '5.1'
end