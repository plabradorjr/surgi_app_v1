require './config/environment'
require 'sinatra/activerecord/rake'

desc 'Interactive Console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

begin
  require 'minitest/autorun'
rescue LoadError => e
  raise e unless ENV['RAILS_ENV'] == "production"
end

def reload
  load_all 'app/models'
end