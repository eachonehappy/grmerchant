class PagesController < ApplicationController
	before_action :authenticate_user!
	before_action :shop_opened , only: [:cart]

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
			
		elsif current_user.admin
		else
			redirect_to closed_shop_path
		end	 
		@orders = Order.all 
		@stat = Stat.first
	end

	def cart
		@cart_recipes = current_user.recipes

		if @cart_recipes.empty?
	  	redirect_to root_path, notice: 'Please Add Recipe Kit In Cart'
	  end 	 
			
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

	def sms_accept
		@stat = Stat.first
		@stat.toggle(:sms_accept)
		@stat.save
	if request.xhr?
      render json: { id: "sms#{current_user.id}" }
    else
      redirect_to request.referer_path
    end
	end

	def send_sms
		
	end

	def accept_sms
		@order = Order.find(params[:format])
		@customer = @order.customer
		HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=Hi+Your+order+is+Confirmed+%3A+%0A+Today+is+20-02-2017+12%3A55%3A23&numbers=#{@customer.phone}&unicode=false&flash=true")
        @order.sms_status = "Accepted"   
        @order.save
        if request.xhr?
      render json: { count: "Accepted" ,id: @order.id }
    else
      redirect_to request.referer_path
    end
	end

	def reject_sms
		@order = Order.find(params[:format])
		@customer = @order.customer

		HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=Hi+Your+order+is+Declined+%3A+%0A+Today+is+20-02-2017+12%3A55%3A23&numbers=#{@customer.phone}&unicode=false&flash=true")
        @order.sms_status = "Rejected"   
        @order.save
        if request.xhr?
      render json: {count: "Rejected" , id: @order.id }
    else
      redirect_to request.referer_path
    end
	end

	def closed_shop
		
	end
end
