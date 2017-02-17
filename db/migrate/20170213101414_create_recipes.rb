class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
    	t.string :sku
    	t.string :name
    	t.integer :serving
    	t.integer :price
    	t.boolean :non_veg

      t.timestamps null: false
    end
  end
end
