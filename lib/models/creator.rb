class Creator < ActiveRecord::Base
  has_many :books
  has_many  :publishers, through: :books
end
