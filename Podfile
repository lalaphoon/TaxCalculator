# Uncomment this line to define a global platform for your project
 platform :ios, '9.0'

target 'TaxCalculator' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TaxCalculator
  pod 'PureLayout'
  pod 'Charts','3.0.4'
 # pod 'RealmSwift', '~> 2.0.2'
  pod 'ChartsRealm'

  post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '4.0'
		end
	end
 end

  target 'TaxCalculatorTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TaxCalculatorUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
