class CreateCustomerUsers < ActiveRecord::Migration
  def change
    create_table :customer_users do |t|
    	t.integer :user_id
    	t.integer :customer_id

      t.timestamps null: false
    end
  end
end
