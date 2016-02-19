Pod::Spec.new do |s|
  s.name = 'RPColor'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A handy wrapper for dealing with color in Swift'
  s.homepage = 'https://github.com/WedgeSparda/RPColor'
  s.social_media_url = 'http://twitter.com/Roberto_Pastor'
  s.authors = {
    'Roberto Pastor' => 'roberto.pastor.ortiz@gmail.com'
  }
  s.source = {
    :git => '',
    :tag => s.version
  }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.source_files = 'Source/*.swift'
end
