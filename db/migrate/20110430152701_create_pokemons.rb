class CreatePokemons < ActiveRecord::Migration
  def self.up
    create_table :pokemons do |t|
      t.string :name
      t.string :description
      t.integer :hit_points
      t.string :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :pokemons
  end
end
