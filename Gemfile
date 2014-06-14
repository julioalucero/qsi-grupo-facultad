source 'https://rubygems.org'
ruby '2.1.2'
gem 'rails', '~> 4.0.0'
gem 'sass-rails', '>= 3.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0.4'

gem 'devise'
gem 'figaro'
gem 'pg'
gem 'slim'
gem 'unicorn'

gem 'omniauth'
gem 'omniauth-facebook'
gem "koala", "~> 1.9.0"

gem 'kaminari'
gem 'ransack'

gem 'acts-as-taggable-on', '~> 3.1.0'
gem 'coveralls', require: false

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'haml-rails'
  gem 'haml2slim'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'rails_best_practices'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'awesome_print'
end

group :test do
  gem 'capybara'
  gem 'minitest-spec-rails'
  gem 'minitest-wscolor'
end

group :production do
  gem 'rails_12factor'
end
