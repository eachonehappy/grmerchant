class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin?
		redirect_to root_path unless current_user.role == "admin"
	end

  def manager?
    redirect_to root_path unless current_user.role == "manager"
  end

  def operator?
    redirect_to root_path unless current_user.role == "operator"
  end

  def data_entry?
    redirect_to root_path unless current_user.role == "data_entry"
  end

  def merchant?
    redirect_to root_path unless current_user.role == "merchant"
  end

  

  def shop_opened
  	@shop_open = Stat.first.shop_open
  	redirect_to root_path unless @shop_open
  end

end
