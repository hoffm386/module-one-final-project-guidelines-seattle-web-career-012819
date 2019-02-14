class Publisher < ActiveRecord::Base
  has_many :books
  has_many :creators, through: :books
end
