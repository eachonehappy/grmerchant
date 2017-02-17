class AddMissingIndexes < ActiveRecord::Migration
  def change
        add_index :order_recipes, :order_id
        add_index :order_recipes, :recipe_id
        add_index :orders, :customer_id
        add_index :orders, :customer_address_id
        add_index :orders, :user_id
        add_index :notes_orders, :order_id
        add_index :customer_users, :user_id
        add_index :customer_users, :customer_id
        add_index :customer_addresses, :customer_id
        add_index :cart_recipes, :recipe_id
        add_index :cart_recipes, :user_id
      end
end
