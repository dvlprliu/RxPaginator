#
# Be sure to run `pod lib lint RxPaginator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxPaginator'
  s.version          = '1.0.0'
  s.summary          = 'Paginating made easy'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A paginator implemented using RxSwift
                       DESC

  s.homepage         = 'https://github.com/dvlprliu/RxPaginator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dvlprliu' => 'dvlprliu@gmail.com' }
  s.source           = { :git => 'https://github.com/dvlprliu/RxPaginator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'RxPaginator/Classes/**/*.{swift}'
  s.swift_versions = ['5.0']

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}'
    test_spec.dependency 'RxTest' # This dependency will only be linked with your tests.
  end

  s.dependency 'RxSwift', '~> 5.0'
  s.dependency 'RxCocoa', '~> 5.0'
  s.dependency 'RxRelay', '~> 5.0'
end
