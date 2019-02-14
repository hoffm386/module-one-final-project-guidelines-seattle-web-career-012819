class Publisher < ActiveRecord::Base
  has_many :books
  has_many :creators, through: :books

  def self.most_books
    most_number =0
    most_publisher = nil
    self.all.each do |publisher|

      if publisher.books.count > most_number
        most_number = publisher.books.count
        most_publisher = publisher
      end

    end
    most_publisher
  end
end
