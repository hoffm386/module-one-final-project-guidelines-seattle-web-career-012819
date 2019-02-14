class CreateTrainer < ActiveRecord::Migration 
    def change
        create_table :trainers do |t|
           t.string :name
           t.string :flavor_text
           t.integer :p1
           t.integer :p2
           t.integer :p3
           t.integer :p4
           t.integer :p5
           t.integer :p6
        end
    end
end
