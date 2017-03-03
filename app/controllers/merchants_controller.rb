class MerchantsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin? || :marketing? , only: [ :destroy, :new]

  def index
	
    @users = User.all - User.where(:role => "admin")
    @user = User.new
  
	end

	def create
    @user = User.new(user_params)
   

    respond_to do |format|
      if @user.save
        format.html { redirect_to merchants_path, notice: 'Merchant was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        @users = User.all - User.where(:role => "admin")
        format.html { render :index }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to merchants_path, notice: 'Merchant was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:format])
    @user.destroy
  
      redirect_to merchants_path, notice: 'Merchant was successfully destroyed.' 
     
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:merchant_pin, :password, :password_confirmation, :full_name, :address, :phone, :non_veg, :role)
    end
end
