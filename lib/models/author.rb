class Author < ActiveRecord::Base
  has_many :book_deals
  has_many :books, through: :book_deals
  has_many :publishers, through: :book_deals
end