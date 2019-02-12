class CreatePokemon < ActiveRecord::Migration 
    def change 
        create_table :pokemons do |t|
            t.name :name
            t.string :height
            t.integer :weight
            t.string :type_1
            t.string :type_2
        end
    end
end