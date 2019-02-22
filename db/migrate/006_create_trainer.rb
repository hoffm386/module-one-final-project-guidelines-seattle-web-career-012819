class CreateTrainer < ActiveRecord::Migration
    def change
        create_table :trainers do |t|
           t.string :name
           t.string :flavor_text
        end
    end
end
