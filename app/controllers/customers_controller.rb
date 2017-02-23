class CustomersController < ApplicationController
	before_action :authenticate_user!
	before_action :shop_opened , only: [:new]
	def new
		
		@cart_recipes = current_user.recipes
		if @cart_recipes.empty?
	  	redirect_to root_path, notice: 'Please Add Recipe Kit In Cart'
	  else
	  	@customer = Customer.new
	  end
	end
end
