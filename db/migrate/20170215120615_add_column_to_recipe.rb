class AddColumnToRecipe < ActiveRecord::Migration
  def change
  	add_column :recipes, :availability, :boolean, default: false
  end
end
