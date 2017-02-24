class SmsMessagesController < ApplicationController

  before_action :authenticate_user!

  
  # GET /sms_messages
  # GET /sms_messages.json
  def index
    @sms_messages = SmsMessage.all
    @sms_message = SmsMessage.new  
    @stat_message = Stat.first.pin
  end

  # GET /sms_messages/1
  # GET /sms_messages/1.json
  def show
  end

  # GET /sms_messages/new
  def new
    @sms_message = SmsMessage.new
  end

  # GET /sms_messages/1/edit
  def edit
    @sms_message = SmsMessage.find(params[:id])
  end

  # POST /sms_messages
  # POST /sms_messages.json
  def create
    @sms_message = SmsMessage.new(sms_message_params)
    @sms_message.user_id = current_user.id

    respond_to do |format|
      if @sms_message.save
        format.html { redirect_to sms_messages_path, notice: 'SmsMessage was successfully created.' }
        format.json { render :show, status: :created, location: @sms_message }
      else
        @sms_messages = SmsMessage.all
        format.html { render :index }
        format.json { render json: @sms_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_messages/1
  # PATCH/PUT /sms_messages/1.json
  def update
    @sms_message = SmsMessage.find(params[:id])
    respond_to do |format|
      if @sms_message.update(sms_message_params)
        format.html { redirect_to sms_messages_path, notice: 'SmsMessage was successfully updated.' }
        format.json { render :show, status: :ok, location: @sms_message }
      else
        format.html { render :edit }
        format.json { render json: @sms_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_messages/1
  # DELETE /sms_messages/1.json
  def destroy
    @sms_message = SmsMessage.find(params[:id])
    @sms_message.destroy
    respond_to do |format|
      format.html { redirect_to sms_messages_url, notice: 'SmsMessage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_sms
    @stat = Stat.first
    @sms_message = SmsMessage.find(params[:format])
    @stat.pin = @sms_message.sms_message
    @stat.save
    redirect_to sms_messages_path
  end

  private
   

    # Never trust parameters from the scary internet, only allow the white list through.
    def sms_message_params
      params.require(:sms_message).permit(:sms_message)
    end
end
