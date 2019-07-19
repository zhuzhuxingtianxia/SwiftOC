project 'TMBuyer.xcodeproj'

# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'TMBuyer' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
   use_frameworks!

  pod 'TalkingData',:path => './PodLib/TalkingData'
  pod 'NTalkerSDK',:path => './PodLib/NTalkerSDK'
  pod 'TencentOpenAPI',:path => './PodLib/TencentOpenAPI'
  pod 'TCMNetworkingKit',:path => './PodLib/TCMNetworkingKit'
  pod 'TCMBase',:path => './PodLib/TCMBase'
  pod 'TCMComponent',:path => './PodLib/TCMComponent'
  pod 'LoginModule',:path => './PodLib/LoginModule'
  pod 'HomeModule',:path => './PodLib/HomeModule'
#  pod 'WeexModule',:path => './PodLib/WeexModule'

  pod 'Masonry', '~> 1.1.0'
  pod 'YYKit', '~> 1.0.9'
  # Pods for TMBuyer

  # 关于WeexSDK中WXLogLevel枚举和微信sdk中的 WXLogLevel冲突的解决方案，重点是引入sdk头文件的顺序：https://bmfe.github.io/2018/04/26/WXLogLevelNaming/
  
  target 'TMBuyerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TMBuyerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
