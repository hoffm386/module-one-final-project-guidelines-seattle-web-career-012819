class CreateCreators.rb < ActiveRecord::Migration[5.0]
  def change
    create_table :creators do |t|
      t.string :name
      t.integer :book_id
      t.integer :publisher_id
    end
  end
end
