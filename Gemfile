source "https://rubygems.org"
ruby "2.6.1"


gem "sinatra"
gem "activerecord", '<= 5.1'
gem "sinatra-activerecord"
gem "bcrypt"
gem "require_all"
gem 'rack-timeout', '0.3.2'

group :development do
  gem 'sqlite3', '~> 1.3.6'
  gem 'shotgun'
  gem 'pry'
end

group :production do
  gem 'pg'
end

group :development, :production do
  gem 'rake'
end