class CreateBookDeals < ActiveRecord::Migration[4.2]
  def change
    create_table :bookdeals do |t|
      t.integer :author_id
      t.integer :book_id
      t.integer :publisher_id
    end
  end
end