require 'bundler'
Bundler.require

require 'JSON'
require 'rest-client'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
