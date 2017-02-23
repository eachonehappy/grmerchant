require "http"
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_user? , only: [:index]
  before_action :shop_opened , only: [:new]

  # GET /orders
  # GET /orders.json
  def index
    
    @orders = Order.all.sort_by(&:created_at).reverse
    @stat = Stat.first
    @stat_second = Stat.new
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @order_recipes = @order.recipes
    @stat = Stat.first

  end

  # GET /orders/new
  def new
   
    @customer_address = CustomerAddress.new
    @order = Order.new
    @notes_order = NotesOrder.new
    @customer = Customer.find_by_phone(params[:customer][:phone])
    if @customer
      @addresses = @customer.customer_addresses 
    else
      @customer = Customer.new
    end  
    @stat = Stat.first
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    if params[:order][:customer_address][:address].present? && params[:order][:customer][:name].present? && params[:mode_of_payment].present?
      @stat = Stat.first
      @order = Order.new(order_params)

      @customer = Customer.find_by_phone(params[:order][:customer][:phone])
      if @customer
        @customer_address = CustomerAddress.find_by_address(params[:order][:customer_address][:address])
        if @customer_address
          @order.customer_address_id = @customer_address.id
        else
          @customer_address = CustomerAddress.new
          @customer_address.address = params[:order][:customer_address][:address]
          @customer_address.customer_id = @customer.id
          @customer_address.save
          @order.customer_address_id = @customer_address.id
        end 

        @order.user_id = current_user.id
        @order.customer_id = @customer.id

        @cart_recipes = current_user.recipes
        
        @cart_recipes.each do |recipe|
          @order.order_recipes.build(:recipe_id => recipe.id)
        end
        @current_user.cart_recipes.destroy_all
        if params[:n1].present?
          @order.notes_orders.build(:description => params[:n1]) 
        end
        if params[:n2].present?
          @order.notes_orders.build(:description => params[:n2]) 
        end
        if params[:n3].present?
          @order.notes_orders.build(:description => params[:n3]) 
        end
        if params[:n4].present?
          @order.notes_orders.build(:description => params[:n4]) 
        end
        @order.mode_of_payment = params[:mode_of_payment]
        if params[:delivery_time].present?
          @order.delivery_time = params[:delivery_time]
          unless params[:delivery_time].split("/")[0] == (Time.now).strftime('%d%m%Y')
            @order.amount = @cart_recipes.map(&:price).inject(0, :+)*(100 - @stat.discount.to_f)/100
            @order.preorder = true
          else
            @order.amount = @cart_recipes.map(&:price).inject(0, :+)  
          end  
        else
          @order.amount = @cart_recipes.map(&:price).inject(0, :+)
          @order.delivery_time = "#{(Time.now).strftime('%d%m%Y')}/#{(Time.now + 2.hours).strftime("%I%p")}-#{(Time.now + 3.hours).strftime("%I%p")}"  
        end
        @order.o_id = "#{current_user.merchant_pin}#{(Time.now).strftime('%d%m%Y')}#{current_user.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).count}"
        
        respond_to do |format|
          if @order.save
            
           @order_recipes = @order.order_recipes
            @message = "Your+Order+"
            @order_recipes.each do |order_recipe|
              @message = @message +"," + "#{order_recipe.recipe.serving}" + "#{order_recipe.recipe.name}"
            end
           
           @message = @message.gsub ' ', '+'
            if @stat.sms_accept
            
               HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=#{@message}+Total+Rs+#{@order.amount}+Delivered+by+#{@order.delivery_time}+is+confirmed+%3A+%0A+Today+is+20-02-2017+12%3A55%3A23&numbers=#{@customer.phone}&unicode=false&flash=true")
              @order.sms_status = "Accepted"
              @order.save
            else
             
              HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=#{@message}+Total+Rs+#{@order.amount}+Delivered+by+#{@order.delivery_time}+is+under+Review+%3A+%0A+Today+is+20-02-2017+12%3A55%3A23&numbers=#{@customer.phone}&unicode=false&flash=true")
              end
              ExampleMailer.sample_email.deliver
            format.html { redirect_to order_path(@order), notice: 'Order was successfull.' }
            format.json { render :show, status: :created, location: @order }
          else
            format.html { render :new }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        end 
      else 
        @customer = Customer.new
    
        @customer.phone = params[:order][:customer][:phone]
        @customer.name = params[:order][:customer][:name]
        @customer.save
       
        @customer_address = CustomerAddress.new
        @customer_address.address = params[:order][:customer_address][:address]
        @customer_address.customer_id = @customer.id
        @customer_address.save
        @order.customer_address_id = @customer_address.id

        @order.user_id = current_user.id
        @order.customer_id = @customer.id

        @cart_recipes = current_user.recipes
        
        @cart_recipes.each do |recipe|
          @order.order_recipes.build(:recipe_id => recipe.id)
        end
        @current_user.cart_recipes.destroy_all
  
        if params[:n1].present?
          @order.notes_orders.build(:description => params[:n1]) 
        end
        if params[:n2].present?
          @order.notes_orders.build(:description => params[:n2]) 
        end
        if params[:n3].present?
          @order.notes_orders.build(:description => params[:n3]) 
        end
        if params[:n4].present?
          @order.notes_orders.build(:description => params[:n4]) 
        end
        @order.mode_of_payment = params[:mode_of_payment]
        if params[:delivery_time].present?
          @order.delivery_time = params[:delivery_time]
          unless params[:delivery_time].split("/")[0] == (Time.now).strftime('%d%m%Y')
            @order.amount = @cart_recipes.map(&:price).inject(0, :+)*(100 - @stat.discount.to_f)/100
            @order.preorder = true
          else
            @order.amount = @cart_recipes.map(&:price).inject(0, :+)  
          end  
        else
          @order.amount = @cart_recipes.map(&:price).inject(0, :+)
          @order.delivery_time = "#{(Time.now).strftime('%d%m%Y')}/#{(Time.now + 2.hours).strftime("%I%p")}-#{(Time.now + 3.hours).strftime("%I%p")}"  
        end  
        @order.o_id = "#{current_user.merchant_pin}#{(Time.now).strftime('%d%m%Y')}#{current_user.orders.where("created_at >= ?", Time.zone.now.beginning_of_day).count}"
        respond_to do |format|
          if @order.save
            @order_recipes = @order.order_recipes
            @message = "Your+Order+"
            @order_recipes.each do |order_recipe|
              @message = @message +"," + "#{order_recipe.recipe.serving}" + "#{order_recipe.recipe.name}"
            end
           @message = @message.gsub ' ', '+'
           if @stat.sms_accept
              HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=#{@message}+Total+Rs+#{@order.amount}+Delivered+by+#{@order.delivery_time}+is+confirmed+%3A+%0A+Today+is+20-02-2017+12%3A55%3A23&numbers=#{@customer.phone}&unicode=false&flash=true")
              @order.sms_status = "Accepted"
              @order.save
            else
              HTTP.get("http://sms.bulksms.net.in/api/pushsms.php?username=RISHII&password=5413&sender=GRFOOD&message=#{@message}+Total+Rs+#{@order.amount}+Delivered+by+#{@order.delivery_time}+is+under+Review+%3A+%0A+Today+is+20-02-2017+12%3A55%3A23&numbers=#{@customer.phone}&unicode=false&flash=true")
              end
              ExampleMailer.sample_email.deliver
               format.html { redirect_to order_path(@order), notice: 'Order was successfull.' }
            format.json { render :show, status: :created, location: @order }
          else
            format.html { render :new }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end  
        end
      end
    else
      redirect_to new_new_order_path, notice: 'Please enter Name & Address & Mode of Payment'
    end  
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def autocomplete
    @customer = Customer.find_by_phone(params[:customer][:phone])
    if @customer
      redirect_to new_order_path
    else
      @customer = Customer.new(phone: params[:customer][:phone])
      redirect_to new_order_path
    end
  end

  def order_delivery
    @order = Order.find(params[:format])
    
    if @order.is_delivered == nil
      @order.is_delivered = false
    elsif @order.is_delivered == false
      @order.is_delivered = true
    end
    @order.save
  if request.xhr?
      render json: { id: params[:format] }
    else
      redirect_to request.referer_path
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:mode_of_payment)
    end
end
