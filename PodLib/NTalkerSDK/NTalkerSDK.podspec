#
#  Be sure to run `pod spec lint NTalkerSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "NTalkerSDK"
  spec.version      = "2.6.5"
  spec.summary      = "NTalkerSDK小能客服"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  DOTO: NTalkerSDK实时在线客服聊天服务系统。
  文档：https://docs.xiaoneng.cn/iossdk/SDK%E5%AF%BC%E5%85%A5%E5%8F%8AXcode%E9%85%8D%E7%BD%AE.html
                   DESC

  spec.homepage     = "http://doc3.xiaoneng.cn/ntalker.php"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #


  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "zhuzijia" => "873391579@qq.com" }
  # Or just: spec.author    = "zhuzijia"
  # spec.authors            = { "zhuzijia" => "873391579@qq.com" }
  # spec.social_media_url   = "https://twitter.com/zhuzijia"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  spec.platform     = :ios, "8.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "8.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/NTalkerSDK.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  # spec.source_files  = "NTalkerSDK/**/*"
  # spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  spec.resources = "NTalkerSDK/NTalkerColorful.bundle", "NTalkerSDK/NTalkerDefault.bundle", "NTalkerSDK/NTalkerGuest.bundle"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #  文档地址：https://docs.xiaoneng.cn/iossdk/SDK%E5%AF%BC%E5%85%A5%E5%8F%8AXcode%E9%85%8D%E7%BD%AE.html
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #
  # 使用了第三方静态库
  # spec.ios.vendored_library = ''
  # spec.ios.vendored_libraries = ''
  spec.vendored_frameworks = 'NTalkerSDK/NTalkerGuestIMKit.framework', 'NTalkerSDK/NTalkerIMCore.framework'

  # spec.framework  = "SomeFramework"
  spec.frameworks = 'AVFoundation', 'Contacts', 'CoreTelephony', 'AddressBook'

  # spec.library   = "iconv"
  spec.libraries = 'sqlite3.0','xml2.2','stdc++','c++'


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true
  spec.static_framework  =  true


  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"
   
   spec.pod_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => '' }
  # 问题：
  # pod lib lint 验证不通过，App normal i386。不支持i386编译，即不能在模拟器下编译。
  # 解决：添加spec.pod_target_xcconfig。
  # 参考： https://www.jianshu.com/p/88180b4d2ab7/
  # 执行命令跳过模拟器验证：pod lib lint --skip-import-validation

end
