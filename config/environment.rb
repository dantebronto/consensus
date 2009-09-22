RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'rspec-rails', :lib => false
  config.gem 'rspec', :lib => false
  config.gem 'haml', :version => "2.2.2"
  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'
  config.gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', :source => 'http://gems.github.com'
end
