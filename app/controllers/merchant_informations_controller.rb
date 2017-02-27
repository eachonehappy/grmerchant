class MerchantInformationsController < ApplicationController
  before_action :admin? , only: [ :destroy, :index]

  def index
	
    @merchant_informations = MerchantInformation.all
    
  
	end

	def new
	  @merchant_information = MerchantInformation.new	
	end

	def create
    @merchant_information = MerchantInformation.new(merchant_information_params)
   

    respond_to do |format|
      if @merchant_information.save
        format.html { redirect_to new_merchant_information_path, notice: 'Merchant was successfully created.' }
        format.json { render :show, status: :created, location: @merchant_information }
      else
        @merchant_informations = MerchantInformation.all - MerchantInformation.where(:role => "admin")
        format.html { render :index }
        format.json { render json: @merchant_information.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @merchant_information = MerchantInformation.find(params[:id])
  end

  # PATCH/PUT /merchant_informations/1
  # PATCH/PUT /merchant_informations/1.json
  def update
    @merchant_information = MerchantInformation.find(params[:id])
    respond_to do |format|
      if @merchant_information.update(merchant_information_params)
        format.html { redirect_to new_merchant_information_path, notice: 'Merchant was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchant_information }
      else
        format.html { render :edit }
        format.json { render json: @merchant_information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchant_informations/1
  # DELETE /merchant_informations/1.json
  def destroy
    @merchant_information = MerchantInformation.find(params[:format])
    @merchant_information.destroy
  
      redirect_to merchant_informations_path, notice: 'Merchant was successfully destroyed.' 
     
  end

  def accept_merchant_information
  	@accept_merchant = MerchantInformation.find(params[:format])
  	@accept_merchant.is_accepted = true
  	@accept_merchant.save
  	redirect_to request.referer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_information
      @merchant_information = MerchantInformation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_information_params
      params.require(:merchant_information).permit( :full_name, :address, :phone, :non_veg)
    end
end
