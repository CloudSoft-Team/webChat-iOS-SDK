Pod::Spec.new do |s|
    s.name         = ‘webChat-iOS’
    s.version      = '0.0.4'
    s.summary      = 'An easy way to use pull-to-refresh'
    s.homepage     = 'https://github.com/CloudSoft-Team/webChat-iOS-SDK'
    s.license      = 'MIT'
    s.authors      = {'Tan Long' => '78928861@qq.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/CloudSoft-Team/webChat-iOS-SDK.git', :tag => s.version}
    s.source_files = '/Users/chenjx/webChat-github/webChat-iOS-SDK/*.{h,m}'
    s.requires_arc = true
end
