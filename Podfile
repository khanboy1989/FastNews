# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

source 'https://github.com/CocoaPods/Specs.git'


target 'FastNews' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!


  # Pods for FastNews
 
  pod 'RxSwift' , '~> 6.6.0'  
  pod 'RxCocoa' , '~> 6.6.0'
  pod 'RxFlow'
  pod 'Action'
  pod 'SwiftLint'
  pod 'Swinject', '2.8.3'
  pod 'SwinjectAutoregistration' , '2.8.3'
  pod 'ModelMapper',  '~> 10.0'
  pod 'Moya/RxSwift',  '~> 15.0'
  pod 'RxDataSources', '~> 5.0'
  pod 'Kingfisher', '~> 7.8.1'




target 'FastNewsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 6.6.0'
    pod 'RxTest', '~>6.6.0'	
  end

  target 'FastNewsUITests' do
    # Pods for testing
  end
	
 end

 

deployment_target = '12.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end


