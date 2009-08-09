RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'rspec-rails', :lib => false
  config.gem 'rspec', :lib => false

  config.gem 'addressable', :version => '2.0.2', :lib => 'addressable/uri'
  config.gem 'data_objects', :version => '0.9.12'
  config.gem 'do_sqlite3', :version => '0.9.12'
  config.gem 'rails_datamapper', :version => '0.9.11'
  config.gem 'dm-migrations', :version => '0.9.11'

  config.gem 'haml', :version => "2.2.2"
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com', :version => '2.3.11'
  config.gem 'jscruggs-metric_fu', :lib => 'metric_fu', :source => 'http://gems.github.com'
  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'

  config.frameworks -= [ :active_record ]
  config.time_zone = 'UTC'
end
