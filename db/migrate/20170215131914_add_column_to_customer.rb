class AddColumnToCustomer < ActiveRecord::Migration
  def change
  	remove_column :customers, :phone, :integer
  	add_column :customers, :phone, :string
  end
end
