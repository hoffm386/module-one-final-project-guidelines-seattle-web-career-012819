class Book < ActiveRecord::Base
  belongs_to :creator
  belongs_to :publisher

  # def self.get_creator_names
  #   author = Book.creator.name
  #   autor
  # end
end
