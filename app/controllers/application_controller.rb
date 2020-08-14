class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # debug_log
  def debug_log(argument)
    Rails.application.config.another_logger.debug(argument)
  end
  
  def after_sign_in_path_for(resource)
    debug_log("[d] Application_Ctrl: ac: after_sign_in_path_for resource = #{resource.inspect}")  # log
    debug_log("[d] Application_Ctrl: ac: after_sign_in_path_for resource.id = #{resource.id}")  # log
    
    user_path(resource.id)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :image, :shop_name, :shop_image, :address, :howto_access, :tel,
      :business_hours, :holiday, :handling_animals, :handling_feeds, :handling_goods, :feature,
      :url, :map_info, :twitter, :facebook ,:instagram] )
  end
end
