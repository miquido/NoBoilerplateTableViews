Pod::Spec.new do |s|

  s.name             = 'NoBoilerplateTableViews'
  s.version          = '0.1.0'
  s.summary          = 'A set of protocols and extensions to simplify the creation of View Controllers with UITableViews.'

  s.description      = <<-DESC
                       A set of protocols and extensions to simplify the creation of View Controllers with UITableViews.
                       It uses RxSwift and RxCocoa under the hood.
                       DESC

  s.homepage         = "https://www.miquido.com/"

  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Andrzej Zuzak' => 'andrzej.zuzak@miquido.com' }
  s.source           = { :git => 'https://github.com/miquido/NoBoilerplateTableViews.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'RxCocoa', '~> 4.0'
  s.source_files = 'NoBoilerplateTableViews/Classes/**/*'
  s.frameworks = 'UIKit'
  s.swift_version = '4.1'

end
