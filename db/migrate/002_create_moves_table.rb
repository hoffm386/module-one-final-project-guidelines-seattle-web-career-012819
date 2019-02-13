class CreateMovesTable < ActiveRecord::Migration 
    def change
        create_table :moves do |t|
           t.string :name 
           t.integer :accuracy
           t.integer :pp
           t.integer :damage
           t.string :move_type 
        end
    end
end