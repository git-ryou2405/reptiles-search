# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_user, only: [:edit, :update, :delete_photo]
  
  # GET /resource/sign_up
  def new
    super
    debug_log("[d] Registrations_Ctrl: ac: new")  # log
  end

  # POST /resource
  def create
    debug_log("[d] Registrations_Ctrl: ac: create")  # log
    super
  end

  # GET /resource/edit
  def edit
    @edit_mode = params[:edit_mode]
    debug_log("[d] Registrations_Ctrl: ac: edit @edit_mode=#{@edit_mode}")  # log
    
    # ショップ情報の入力を催促
    if params[:jadge_shop_name] == "no_shop_name"
      flash[:danger] = "ショップ情報をご登録ください。"
      @signup = "no_shop_name"
    end
      @signup = "no_shop_name" if params[:signup] == "no_shop_name"
    super
    debug_log("[d] Registrations_Ctrl: ac: edit test")  # log
  end

  # PUT /resource
  def update
    debug_log("[d] Registrations_Ctrl: ac: update id=#{current_user.id}")  # log
    debug_log("[d] Registrations_Ctrl: ac: update search_map=#{params[:search_map]}")  # log
    super
    
    # googleMap_緯度経度の取得
    if @user.saved_change_to_shop_name? || @user.saved_change_to_address? || @user.saved_change_to_search_map?
      debug_log("[d] Registrations_Ctrl: ac: update first if")  # log
      
      # ショップ名でマップ検索
      if @user.search_map == 1
        debug_log("[d] Registrations_Ctrl: ac: update second if")  # log
        if @user.shop_name.blank?
          @user.map_info = ""
          if @user.address.present?
            search_map_set_latlng
            @user.search_map = 2
          end
          @user.save
          debug_log("[d] Registrations_Ctrl: ac: update ..shop_name=#{@user.shop_name}")  # log
        else
          base_url = "https://maps.google.co.jp/maps?output=embed&q="
          @user.map_info = base_url + @user.shop_name
          @user.save
          debug_log("[d] Registrations_Ctrl: ac: search_map_set_latlng @user.map_info(search_map)=#{@user.map_info}")  # log
        end
        
      # 住所でマップ検索
      elsif @user.search_map == 2
        debug_log("[d] Registrations_Ctrl: ac: update second if")  # log
        if @user.address.blank?
          @user.map_info = ""
          @user.save
          debug_log("[d] Registrations_Ctrl: ac: update ..address=#{@user.address}")  # log
        else
          search_map_set_latlng
        end
      elsif @user.search_map == 3
        @user.map_info = ""
        @user.save
      end
    end
    debug_log("[d] Registrations_Ctrl: ac: update ..map_info=#{@user.map_info}")  # log
  end

  # DELETE /resource
  def destroy
    debug_log("[d] Registrations_Ctrl: ac: destroy")  # log
    super
  end
  
  # shop_images削除
  def delete_photo
    debug_log("[d] Registrations_Ctrl: ac: delete_photo")  # log
    debug_log("[d] Registrations_Ctrl: ac: delete_photo @user=#{@user.inspect}")  # log
    if @user.shop_images.present?
      @user.shop_images = ""
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
    debug_log("[d] Registrations_Ctrl: ac: update_resourc resource=#{resource.inspect}")  # log
    debug_log("[d] Registrations_Ctrl: ac: update_resourc params=#{params.inspect}")  # log
    resource.update_without_password(params)
  end
  
  # ユーザーID取得
  def set_user
    if params[:id]
      debug_log("[d] Registrations_Ctrl: ac: set_user id=#{params[:id]}")  # log
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
    debug_log("[d] Registrations_Ctrl: ac: search_map_set_latlng @user.map_info(address)=#{@user.map_info}")  # log
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
