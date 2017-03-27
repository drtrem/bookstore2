class SettingsController < ApplicationController
  include SettingsHelper

  before_action :authenticate_user!
  before_action :set_user, only: [:index, :update, :update_password]

  def update
    @user.update_attributes(user_params)
    redirect_to settings_index_path
  end

  def update_password
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "index"
    end
  end

  def destroy 
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)  
    set_flash_message :notice, :destroyed if is_flashing_format?  
    yield resource if block_given?  
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }  
  end  

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password, :email, :first_name, :last_name, :address, :city, :zip, :country, :phone, :shipping_first_name, :shipping_last_name, :shipping_address, :shipping_city, :shipping_zip, :shipping_country, :shipping_phone)
  end
end

