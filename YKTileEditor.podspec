Pod::Spec.new do |s|
    s.name = 'YKTileEditor'
    s.version = '0.4.0'
    s.license = 'MIT'
    s.homepage = 'http://www.yellokrow.com'
    s.authors = 'yellokrow'
    s.summary = 'YKTileEditor framework for pixel manipulation and palette selection'
    s.source  = { :git => 'https://github.com/yellokrow/YKTileEditor.git', :tag => '0.4.0' }
    s.source_files = 'YKTileEditor/*.swift'
    s.osx.deployment_target = '10.11'
    s.resource = 'YKTileEditor/*.xib'
    s.swift_version = '4.1'

    s.dependency 'XCGLogger', '~> 6.0.2'
end
