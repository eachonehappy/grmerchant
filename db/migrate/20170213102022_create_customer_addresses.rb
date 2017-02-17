class CreateCustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
    	t.text :address
        t.integer :customer_id
      t.timestamps null: false
    end
  end
end
