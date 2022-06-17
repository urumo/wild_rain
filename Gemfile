# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'rubocop', '~> 1.30'
gem 'sidekiq', '~> 6.5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 5.1.2'
end
group :development do
  gem 'spring'
end

# gem "redis", "~> 4.0"
# gem "kredis"
# gem "rack-cors"
