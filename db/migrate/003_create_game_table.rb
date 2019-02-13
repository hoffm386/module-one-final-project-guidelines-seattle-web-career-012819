class CreateGameTable < ActiveRecord::Migration
    def change
        create_table :games do |t|
           t.string :name
           t.integer :generation
           t.string :release_date
        end
    end
end
