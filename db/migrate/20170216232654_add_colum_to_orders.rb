class AddColumToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :delivery_time, :string
  end
end
