class AddColumnToRecipes < ActiveRecord::Migration
  def change
  	add_column :recipes, :cusine, :string
  end
end
