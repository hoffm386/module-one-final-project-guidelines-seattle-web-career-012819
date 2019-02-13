class CreatePokemon < ActiveRecord::Migration 
    def change
        create_table :pokemons do |t|
            t.string :name
            t.string :height
            t.integer :weight
            t.string :type_array, array: true, default: []
            t.string :url
        end
    end
end
