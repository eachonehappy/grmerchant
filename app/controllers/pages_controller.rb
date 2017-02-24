class PagesController < ApplicationController
	before_action :authenticate_user!
	before_action :shop_opened , only: [:cart]
	before_action :admin? , only: [:update_discount]
  def home
		if current_user.role == "data_entry"
			redirect_to recipes_path
		elsif current_user.role == "marketing"
			redirect_to sms_messages_path	
		else	
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
			    elsif params[:format] == "All"
			    	@recipes = @recipes	
			    end
			  end	
			else
				@recipes = Recipe.all.where(non_veg: false).where(availability: true)
		
			  if params[:format].present?
			  	if params[:format] == "Indian"
			  	  @recipes = @recipes.where(cusine: "Indian")
			    elsif params[:format] == "Chinese"
			    	@recipes = @recipes.where(cusine: "Chinese")
			   elsif params[:format] == "Continental"
		    	  @recipes = @recipes.where(cusine: "Continental")
			    elsif params[:format] == "Italian"
			    	@recipes = @recipes.where(cusine: "Italian") 
			    elsif params[:format] == "All"
			    	@recipes = @recipes		
			    end
			  end
			end
			
		elsif current_user.role == "data_entry" || current_user.role == "manager" || current_user.role == "operator" || current_user.role == "admin"
		else
			redirect_to closed_shop_path
		end	 

		@orders = Order.all.sort_by(&:created_at).reverse
		@stat = Stat.first
		@stat_second = Stat.new
	end
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
		redirect_to orders_path
	end

	def update_pin
		
		@stat = Stat.first
		@stat.pin = params[:stat][:pin]
		@stat.save
		redirect_to orders_path
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
    @stat_message = Stat.first.pin.gsub ' ', '+'
		@customer = @order.customer
		@order_recipes = @order.order_recipes
            @message = "Your+Order+"
            @order_recipes.each do |order_recipe|
              @message = @message +"," + "#{order_recipe.recipe.serving}" + "#{order_recipe.recipe.name}"
            end
           
           @message = @message.gsub ' ', '+'
		 HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=#{@message}+Total+Rs+#{@order.amount}+Delivered+by+#{@order.delivery_time}+is+confirmed+#{@stat_message}&numbers=#{@customer.phone}&unicode=false&flash=true")
              
		 @order.sms_status = "Accepted" 
		 if @order.is_delivered == nil
		      @order.is_delivered = false
		  end  
        @order.save

        if request.xhr?
      render json: { count: "Accepted" ,id: @order.id }
    else
      redirect_to request.referer_path
    end
	end

	def reject_sms
        @stat_message = Stat.first.pin.gsub ' ', '+'
		@order = Order.find(params[:order_id])
		@customer = @order.customer

		@order_recipes = @order.order_recipes
            @message = "+"
            @order_recipes.each do |order_recipe|
              @message = @message +"," + "#{order_recipe.recipe.serving}" + "#{order_recipe.recipe.name}"
            end
           
           @message = @message.gsub ' ', '+'
           @form_message = params[:stat][:discount].gsub ' ', '+'

		 HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=#{@form_message}+#{@message}+Total+Rs+#{@order.amount}+cannot+be+delivered+#{@stat_message}&numbers=#{@customer.phone}&unicode=false&flash=true")
          @order.sms_status = "Rejected"   
        @order.save
     
      redirect_to request.referer_path
    
	end

	def closed_shop
		
	end
end
