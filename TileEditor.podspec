Pod::Spec.new do |s|
    s.name = 'TileEditor'
    s.version = '0.4.0'
    s.license = 'GPL'
    s.homepage = 'http://www.yellokrow.com'
    s.authors = 'yellokrow'
    s.summary = 'TileEditor framework for pixel manipulation and palette selection'
    s.source  = { :git => 'https://github.com/yellokrow/TileEditor.git', :branch => 'development' }
    s.source_files = 'TileEditor/*.swift'
    s.osx.deployment_target = '10.12'
    s.resource = 'TileEditor/*.xib'
    s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

    s.dependency 'XCGLogger'
end
