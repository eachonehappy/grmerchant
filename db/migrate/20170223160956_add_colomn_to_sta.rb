class AddColomnToSta < ActiveRecord::Migration
  def change
  	add_column :stats, :pin, :string
  end
end
