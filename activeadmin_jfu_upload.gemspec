lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activeadmin/jfu_upload/version'

Gem::Specification.new do |spec|
  spec.name          = 'activeadmin_jfu_upload'
  spec.version       = ActiveAdmin::JfuUpload::VERSION
  spec.summary       = 'jQuery-File-Upload for ActiveAdmin'
  spec.description   = 'An Active Admin plugin to use jQuery-File-Upload component'
  spec.license       = 'MIT'
  spec.authors       = ['Mattia Roccoberton']
  spec.email         = 'mat@blocknot.es'
  spec.homepage      = 'https://github.com/blocknotes/activeadmin_jfu_upload'

  spec.files         = Dir['{app,lib}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeadmin', '~> 2.0'

  spec.add_development_dependency 'activestorage', '~> 6.0'
  spec.add_development_dependency 'capybara', '~> 3.33'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'puma', '~> 4.3'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4'
  spec.add_development_dependency 'rspec-rails', '~> 4.0'
  spec.add_development_dependency 'sassc', '~> 2.4'
  spec.add_development_dependency 'selenium-webdriver', '~> 3.142'
  spec.add_development_dependency 'simplecov', '~> 0.19'
  spec.add_development_dependency 'sprockets-rails', '~> 3.2'
  spec.add_development_dependency 'sqlite3', '~> 1.4'
end
