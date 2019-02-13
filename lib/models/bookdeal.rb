class BookDeal < ActiveRecord::Base
  belongs_to :author
  belongs_to :book
  belongs_to :publisher
end