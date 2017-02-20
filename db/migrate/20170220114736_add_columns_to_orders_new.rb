class AddColumnsToOrdersNew < ActiveRecord::Migration
  def change
  	add_column :orders, :message, :string
  end
end
