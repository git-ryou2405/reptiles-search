# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_user, only:[:edit, :delete_photo]
  
  # GET /resource/sign_up
  def new
    super
    debug_log("[d] Registrations_Ctrl: ac: new")  # log
  end

  # POST /resource
  def create
    debug_log("[d] Registrations_Ctrl: ac: create")  # log
    super
    debug_log("[d] Registrations_Ctrl: ac: create id:#{current_user.id}")  # log
  end

  # GET /resource/edit
  def edit
    @edit_mode = params[:edit_mode]
    debug_log("[d] Registrations_Ctrl: ac: edit @edit_mode = #{@edit_mode}")  # log
    super
  end

  # PUT /resource
  def update
    debug_log("[d] Registrations_Ctrl: ac: update id:#{current_user.id}")  # log
    
    super
    
    # googleMap_緯度経度の取得
    unless @user.address.present?
      @user.map_info = ""
      @user.save
    else
      search_map_set_latlng if @user.saved_change_to_address?
    end
    
    debug_log("[d] Registrations_Ctrl: ac: update ..address = #{@user.address}")  # log
    debug_log("[d] Registrations_Ctrl: ac: update ..map_info = #{@user.map_info}")  # log
  end

  # DELETE /resource
  def destroy
    debug_log("[d] Registrations_Ctrl: ac: destroy")  # log
    super
  end
  
  def delete_photo
    debug_log("[d] Registrations_Ctrl: ac: delete_photo")  # log
    debug_log("[d] Registrations_Ctrl: ac: delete_photo @user = #{@user.inspect}")  # log
    if @user.shop_image.present?
      @user.shop_image = ""
      @user.save
      debug_log("[d] Registrations_Ctrl: ac: delete_photo")  # log
    end
    
    flash[:success] = "ショップ画像を削除しました"
    
    redirect_to edit_user_registration_path(edit_mode: "info")
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
  
  # ユーザー新規登録後のリダイレクト先を変更
  def after_inactive_sign_up_path_for(resource)
    user_path(resource)
  end
  
  # ユーザー情報の更新時のリダイレクト先を変更
  def after_update_path_for(resource)
    debug_log("[d] Registrations_Ctrl: ac: after_update_path_for")  # log
    user_path(resource)
  end
  
  # ユーザ情報変更時の「パスワードの確認」を無効にする
  def update_resource(resource, params)
    debug_log("[d] Registrations_Ctrl: ac: update_resource (パスワードの確認を無効)")  # log
    debug_log("[d] Registrations_Ctrl: ac: update_resourc resource = #{resource.inspect}")  # log
    debug_log("[d] Registrations_Ctrl: ac: update_resourc params = #{params.inspect}")  # log
    resource.update_without_password(params)
  end
  
  # ユーザーID取得
  def set_user
    if params[:id]
      debug_log("[d] Registrations_Ctrl: ac: set_user id: #{params[:id]}")  # log
      @user = User.find(params[:id])
    end
  end
  
  # geocodingを用いてGoogleMap用のURLを作成と格納
  def search_map_set_latlng
    base_url = "https://maps.google.co.jp/maps?output=embed&q="
    
    geocoding_search_url = "https://www.geocoding.jp/api/?q=" + @user.address
    
    uriencode = URI.encode(geocoding_search_url)
    uri = URI.parse(uriencode)
    hash = Hash.from_xml open(uri).read
    json = hash.to_json
    jsonhash = JSON.parse(json)
    lat = jsonhash['result']['coordinate']['lat']
    lng = jsonhash['result']['coordinate']['lng']
    
    @user.map_info = base_url + lat + "," + lng
    @user.save
    debug_log("[d] Registrations_Ctrl: ac: search_map_set_latlng")  # log
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
