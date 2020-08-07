class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # debug_log
  def debug_log(argument)
    Rails.application.config.another_logger.debug(argument)
  end
  
  def after_sign_in_path_for(resource)
    debug_log("[d] Application_Ctrl: resource = #{resource.inspect}")  # デバッグ出力
    debug_log("[d] Application_Ctrl: resource.id = #{resource.id}")  # デバッグ出力
    
    user_path(resource.id)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :shop_name, :address, :howto_access, :tel, :business_hours, :holiday, :url])
  end
end
