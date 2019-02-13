class Publisher < ActiveRecord::Base
  has_many :authors, through: :book_deals
  has_many :books, through: :book_deals
end