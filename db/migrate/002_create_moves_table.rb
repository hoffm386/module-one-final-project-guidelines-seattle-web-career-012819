class CreateMovesTable < ActiveRecord::Migration 
    def change
        create_table :moves do |t|
           t.string :name 
           t.string :accuracy
           t.string :pp
           t.integer :damage
           t.string :type 
        end
    end
end