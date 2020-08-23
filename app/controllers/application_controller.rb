class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # debug_log
  def debug_log(argument)
    Rails.application.config.another_logger.debug(argument)
  end
  
  # ログイン実行
  def after_sign_in_path_for(resource)
    debug_log("[d] Application_Ctrl: ac: after_sign_in_path_for resource = #{resource.inspect}")  # log
    debug_log("[d] Application_Ctrl: ac: after_sign_in_path_for resource.id = #{resource.id}")  # log
    
    if resource.shop_name.present?
      user_path(resource)
    else
      edit_user_registration_path(edit_mode: "info", signup: "no_shop_name")
    end
  end
  
  def test
    redirect_to root_path
  end
  
  # ショップ情報 ストロングパラメーター
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :image, :shop_name, {shop_images: [] }, :prefectures,:address, :search_map,:howto_access, :tel,
      :business_hours, :holiday, :handling_animals, :handling_feeds, :handling_goods, :feature,
      :url, :map_info, :twitter, :facebook ,:instagram] )
  end
end
