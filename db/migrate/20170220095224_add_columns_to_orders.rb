class AddColumnsToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :sms_status, :string , default: "default"
  end
end
