class PagesController < ApplicationController
	before_action :authenticate_user!

	def home
		@shop_open = Stat.first.shop_open
		if @shop_open
			if current_user.non_veg
			  @recipes = Recipe.all.where(availability: true)
			  if params[:format].present?
			  	if params[:format] == "Indian"
			  	  @recipes = @recipes.where(cusine: "Indian")
			    elsif params[:format] == "Chinese"
			    	@recipes = @recipes.where(cusine: "Chinese")
		    	elsif params[:format] == "Continental"
		    	  @recipes = @recipes.where(cusine: "Continental")
			    elsif params[:format] == "Italian"
			    	@recipes = @recipes.where(cusine: "Italian")
			    end
			  end	
			else
				@recipes = Recipe.all.where(non_veg: false).where(availability: true)
			  #byebug
			  if params[:format].present?
			  	if params[:format] == "Indian"
			  	  @recipes = @recipes.where(cusine: "Indian")
			    elsif params[:format] == "Chinese"
			    	@recipes = @recipes.where(cusine: "Chinese")
			   elsif params[:format] == "Continental"
		    	  @recipes = @recipes.where(cusine: "Continental")
			    elsif params[:format] == "Italian"
			    	@recipes = @recipes.where(cusine: "Italian") 	
			    end
			  end
			end
			
		else
			@recipes = []
		end	 
		@orders = Order.all 
		@stat = Stat.first
	end

	def cart
		@cart_recipes = current_user.recipes
	end

	def my_orders
		@orders = current_user.orders
		@orders_total = @orders.map(&:amount).inject(0, :+)
	end

	def shop_open
		@stat = Stat.first
		@stat.toggle(:shop_open)
		@stat.save
	if request.xhr?
      render json: { id: current_user.id }
    else
      redirect_to request.referer_path
    end
	end
	
	def update_discount
		@stat = Stat.first
		@stat.discount = params[:stat][:discount]
		@stat.save
		redirect_to root_path
	end
end
