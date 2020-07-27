source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap'
gem 'bootstrap-glyphicons'
gem 'bootswatch'
gem 'devise'
gem 'jquery-rails'
gem 'omniauth'
gem 'omniauth-github'
gem 'faker', '~> 2.13'

group :development, :test do
  gem 'awesome_print', '~> 1.8'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.0'
  gem 'guard', '~> 2.16', '>= 2.16.2'
  gem 'guard-livereload', '~> 2.5', '>= 2.5.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
end

group :test do
  gem 'capybara', '~> 3.33'
  gem 'simplecov', '~> 0.18.5', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
