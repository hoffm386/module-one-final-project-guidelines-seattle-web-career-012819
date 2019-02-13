class CreateBooks < ActiveRecord::Migration[4.2]
    def change 
        create_table :books do |t|
            t.string :title
            t.string :publish_date
            t.integer :page_count
            t.float :price
        end
    end
end