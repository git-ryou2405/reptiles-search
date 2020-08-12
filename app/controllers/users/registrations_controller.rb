# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_user, only:[:edit]
  
  # GET /resource/sign_up
  def new
    super
    debug_log("[d] Registrations_Ctrl: action: new")  # log
  end

  # POST /resource
  def create
    debug_log("[d] Registrations_Ctrl: action: create")  # log
    super
    debug_log("[d] Registrations_Ctrl: action: create id:#{current_user.id}")  # log
  end

  # GET /resource/edit
  def edit
    @edit_mode = params[:edit_mode]
    debug_log("[d] Registrations_Ctrl: action: edit @edit_mode = #{@edit_mode}")  # log
    super
  end

  # PUT /resource
  def update
    debug_log("[d] Registrations_Ctrl: action: update id:#{current_user.id}")  # log
    
    super
    
    # googleMap_緯度経度の取得
    unless @user.address.present?
      @user.map_info = ""
      @user.save
    else
      search_map_set_latlng if @user.saved_change_to_address?
    end
    
    debug_log("[d] Registrations_Ctrl: action: update ..address = #{@user.address}")  # log
    debug_log("[d] Registrations_Ctrl: action: update ..map_info = #{@user.map_info}")  # log
  end

  # DELETE /resource
  def destroy
    debug_log("[d] Registrations_Ctrl: action: destroy")  # log
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  
  # ユーザ情報変更時の「パスワードの確認」を無効にする
  def update_resource(resource, params)
    debug_log("[d] Registrations_Ctrl: action: update_resource (パスワードの確認を無効)")  # log
    debug_log("[d] Registrations_Ctrl: action: update_resourc resource = #{resource.inspect}")  # log
    debug_log("[d] Registrations_Ctrl: action: update_resourc params = #{params.inspect}")  # log
    resource.update_without_password(params)
  end
  
  # ユーザー情報の更新時のリダイレクト先を変更
  def after_update_path_for(resource)
    debug_log("[d] Registrations_Ctrl: action: after_update_path_for")  # log
    user_path(resource)
  end
  
  # ユーザー新規登録後のリダイレクト先を変更
  def after_inactive_sign_up_path_for(resource)
    user_path(resource)
  end
  
  # ユーザーID取得
  def set_user
    if params[:id]
      debug_log("[d] Users_Ctrl: index id: #{params[:id]}")  # log
      @user = User.find(params[:id])
    end
  end
  
  # geocodingを用いてGoogleMap用のURLを作成と格納
  def search_map_set_latlng
    base_url = "https://maps.google.co.jp/maps?output=embed&q="
    
    geocoding_search_url = "https://www.geocoding.jp/api/?q=" + @user.address
    
    uriencode = URI.encode(geocoding_search_url)
    uri = URI.parse(uriencode)            # url
    hash = Hash.from_xml open(uri).read   # 
    json = hash.to_json
    jsonhash = JSON.parse(json)
    lat = jsonhash['result']['coordinate']['lat']
    lng = jsonhash['result']['coordinate']['lng']
    
    @user.map_info = base_url + lat + "," + lng
    @user.save
    debug_log("[d] Registrations_Ctrl: action: search_map_set_latlng")  # log
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
