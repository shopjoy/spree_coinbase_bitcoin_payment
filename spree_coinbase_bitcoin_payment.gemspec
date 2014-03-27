# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_coinbase_bitcoin_payment'
  s.version     = '2.1.4'
  s.summary     = 'Adds Coinbase payment method to Spree Commerce to accept Bitcoin'
  s.description = s.summary
  s.required_ruby_version = '>= 2.0.0'

  s.author    = 'ShopJoy Australia'
  s.email     = 'admin@shopjoy.com.au'
  s.homepage  = 'http://www.shopjoy.com.au/'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.1.4'
  s.add_dependency 'json', '~> 1.8'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
