platform :ios, '13.0'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'gazers' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for gazers

  target 'gazersTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'gazersUITests' do
    testing_pods
  end

end
