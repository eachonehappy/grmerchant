class OrderRecipe < ActiveRecord::Base
	belongs_to :order
	belongs_to :recipe

end
