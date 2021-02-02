# ignore all warnings from all pods
inhibit_all_warnings!

use_frameworks!
workspace 'Tweetx'

def reactivePods
    # Pods for RxSwift & RxCocoa
    pod 'RxSwift', '~> 5'
    pod 'RxCocoa', '~> 5'
    
    # Pods for PromiseKit
    pod 'PromiseKit', '~> 6.8'
end

# CrescendoesStudent project module --------
target 'Tweetx' do
  project 'Tweetx'

  reactivePods

  # Pod for lottie animations
  pod 'lottie-ios'

  # Pod for alamofire
  pod 'Alamofire', '~> 5.2'

  # Pod for keychain access
  pod 'KeychainAccess'

  # Pod for SDWebImage
  pod 'SDWebImage', '~> 5.0'
end

# Shared modules --------
target 'Common' do
    project 'Common/Common'
    
    reactivePods
    
    # Pod for lottie animations
    pod 'lottie-ios'
end

target 'TXKit' do
    project 'TXKit/TXKit'
    
    reactivePods
    
    # Pod for alamofire
    pod 'Alamofire', '~> 5.2'
    
    # Pod for keychain access
    pod 'KeychainAccess'
end

# Feature modules --------
target 'Launch' do
    project 'Launch/Launch'
    
    reactivePods
end

# Post install
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete('IPHONEOS_DEPLOYMENT_TARGET')
      config.build_settings.delete('CODE_SIGNING_ALLOWED')
      config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
  end
end
