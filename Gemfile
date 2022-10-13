source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'jbuilder', '~> 2.5'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.2'
gem 'sassc-rails'
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'

# Mailgun for emailing
gem 'mailgun-ruby', '~>1.1.6'

# Image processing - for active storage variants
gem 'image_processing', '~> 1.12'

# Active storage - Digital Ocean spaces support
gem 'aws-sdk-s3', '~> 1'

# Authentication
gem 'jwt'
gem 'omniauth', '~> 1.6.1'
gem 'omniauth-auth0', '~> 2.0.0'

# Admin
gem 'trestle'
gem 'trestle-active_storage'

# Services
gem 'simple_command'

# Sentry
gem 'sentry-raven'

# Pagination
gem 'kaminari'

# Background jobs
gem 'redis-namespace'
gem 'sidekiq'
gem 'sidekiq-status'

# Console
gem 'awesome_print'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
