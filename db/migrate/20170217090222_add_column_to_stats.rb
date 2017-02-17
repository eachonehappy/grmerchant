class AddColumnToStats < ActiveRecord::Migration
  def change
  	add_column :stats, :discount, :string , default: nil
  end
end
