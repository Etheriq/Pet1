# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

def standart_pods
    pod 'Alamofire'
    pod 'Moya'
    pod 'ObjectMapper'
    pod 'PromiseKit'
    pod 'FXKeychain'
    pod 'RealmSwift'
    
    pod 'Bolts'
    pod 'FBSDKCoreKit'
    pod 'FBSDKShareKit'
    pod 'FBSDKLoginKit'
end

target 'pet1' do
    standart_pods
end

target 'pet1_dev' do
    standart_pods
end

post_install do |installer|
    installer.pods_project.targets.each  do |target|
        target.build_configurations.each  do |config| config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
