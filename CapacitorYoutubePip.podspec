
Pod::Spec.new do |s|
  s.name = 'CapacitorYoutubePip'
  s.version = '1.0.0'
  s.summary = 'YouTube PiP plugin for Capacitor'
  s.license = 'MIT'
  s.homepage = 'https://github.com/MMaEngenharia/capacitor-youtube-pip'
  s.author = 'Marcos Macedo'
  s.source = { :git => 'https://github.com/MMaEngenharia/capacitor-youtube-pip.git', :tag => 'main' }
  s.source_files = 'ios/Plugin/**/*.{swift,h,m,c}'
  s.ios.deployment_target = '15.0'
  s.dependency 'Capacitor'
  s.swift_version = '5.1'
end
