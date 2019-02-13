require 'bundler'
Bundler.require

require 'json'
require 'rest-client'
require 'pry'
require 'uri' # New gem for proper uri encoding of search terms

ActiveRecord::Base.logger = nil

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
