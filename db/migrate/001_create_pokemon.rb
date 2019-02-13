class CreatePokemon < ActiveRecord::Migration
    def change
        create_table :pokemons do |t|
            t.string :name
            t.string :height
            t.integer :weight
            t.string :type1
            t.string :type2
            t.string :url
        end
    end
end
