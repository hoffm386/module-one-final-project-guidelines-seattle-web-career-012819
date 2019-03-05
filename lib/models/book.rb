class Book < ActiveRecord::Base
  # The books_count counter cache means every time a book is inserted, the
  # books_count column for its creator goes up by 1
  belongs_to :creator, :counter_cache => :books_count
  # The creators_count counter cache means every time a book is inserted, the
  # creators_count column for its publisher goes up by 1 if the author isn't
  # associated with the publisher yet
  belongs_to :publisher, :counter_cache => :creators_count
end
