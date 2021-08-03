#
# Be sure to run `pod lib lint ATToast.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name                    = 'ATToast'
    s.version                 = '0.1.8'
    s.summary                 = 'Toast view'
    s.homepage                = 'https://github.com/ablettchen/ATToast'
    s.license                 = { :type => 'MIT', :file => 'LICENSE' }
    s.author                  = { 'ablett' => 'ablettchen@gmail.com' }
    s.source                  = { :git => 'https://github.com/ablettchen/ATToast.git', :tag => s.version.to_s }
    s.ios.deployment_target   = '10.0'
    s.source_files            = 'ATToast/**/*.{h,m}'
    s.requires_arc            = true

    s.dependency 'ATCategories'
    s.dependency 'Masonry'

end
