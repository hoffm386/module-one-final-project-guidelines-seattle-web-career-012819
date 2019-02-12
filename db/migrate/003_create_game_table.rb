class CreateGameTable < ActiveRecord::Migration 
    def change
        create_table :games do |t|
           t.string :name 
           t.integer :generation
        end
    end
end