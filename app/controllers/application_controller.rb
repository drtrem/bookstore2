class ApplicationController < ActionController::Base

  include CurrentCart
  include CanCan::ControllerAdditions
  
  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart
  before_action :set_labels

  def authenticate_admin!
    if current_user   
      redirect_to new_user_session_path unless current_user.role?(:admin)
    else
      redirect_to new_user_session_path
    end
  end

  protected
    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def set_labels
    @labels = Category.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password) }
  end
end
