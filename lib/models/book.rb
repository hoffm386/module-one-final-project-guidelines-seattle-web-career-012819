class Book < ActiveRecord::Base
  has_many :book_deals
  has_many :authors, through: :book_deals
  has_many :publishers, through: :book_deals
end