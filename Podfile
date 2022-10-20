# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'E-detailer' do

	pod 'AFNetworking'
	pod 'ObjectMapper'
  pod 'Alamofire'
	pod 'BEMCheckBox'
  pod 'Zip'
	pod 'Player'

  pod 'RLBAlertsPickers', :git => 'https://github.com/savasadar/Alerts-Pickers.git', :branch => 'master'
  pod 'ActionSheetPicker-3.0'
  pod 'IQKeyboardManagerSwift'
   pod 'DatePickerDialog'
  pod 'Cosmos', '~> 23.0'
pod 'M13Checkbox'
pod 'SwiftyJSON'
pod 'RealmSwift'


	
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for E-detailer

  target 'E-detailerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'E-detailerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end



post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
