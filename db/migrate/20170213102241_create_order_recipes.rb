class CreateOrderRecipes < ActiveRecord::Migration
  def change
    create_table :order_recipes do |t|
    	t.integer :order_id 
    	t.integer :recipe_id

      t.timestamps null: false
    end
  end
end
