 Pod::Spec.new do |s|
    
    # meta infos
    s.name             = "GetLaid"
    s.version          = "1.1.2"
    s.summary          = "AutoLayout Wrapper"
    s.description      = "The shortest most readable AutoLayout code you'll ever write"
    s.homepage         = "http://flowtoolz.com"
    s.license          = 'MIT'
    s.author           = { "Flowtoolz" => "contact@flowtoolz.com" }
    s.source           = {  :git => "https://github.com/flowtoolz/GetLaid.git",
                            :tag => s.version.to_s }
    
    # compiler requirements
    s.requires_arc = true
    s.swift_version = '4.1'
    
    # minimum platform SDKs
    s.platforms = {:ios => "9.0", :osx => "10.11", :tvos => "9.0"}

    # minimum deployment targets
    s.ios.deployment_target  = '9.0'
    s.osx.deployment_target = '10.11'
    s.tvos.deployment_target = '9.0'

    # sources
    s.source_files = 'Code/AllPlatforms/**/*.swift'
    s.ios.source_files = 'Code/UIKit/**/*.swift'
    s.tvos.source_files = 'Code/UIKit/**/*.swift'
    s.osx.source_files = 'Code/AppKit/**/*.swift'

end
