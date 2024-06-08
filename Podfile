platform :ios, '17.0'
use_frameworks!
inhibit_all_warnings!

target 'Demo' do
  pod 'Alamofire'
  pod 'ProgressHUD'
end


######################################### Post Install #########################################
post_install do |installer|
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
          end
      end
  end
end
