class UsersController < ApplicationController
  before_action :set_user, only:[:show]
  # require 'active_support'
  # require 'active_support/core_ext'
  # require 'open-uri'
  # require 'net/http'
  # require 'uri'
  # require 'json'

  def show
    debug_log("[d] Users_Ctrl: action: show")  # log
    
    @show_option = "user"
    
    # ユーザーが持つ、タイプ毎のReptile情報を取得
    if params[:reptile_type].present?
      @show_option = params[:reptile_type]
      # @reptile_type = User.where(id: Reptile.where(type1: params[:reptile_type]).select(current_user.id))
      @reptile_type = Reptile.where(type1: params[:reptile_type], user_id: current_user.id)
      debug_log("[d] Users_Ctrl: action: show @show_option = #{@reptile_type}")  # log
    end
    debug_log("[d] Users_Ctrl: action: show @show_option = #{@show_option}")  # log
    
    # gon.address = @user.address
    # gon.userid = @user.id
    # if @user.map_info.empty?
    #   @user.map_info = params[:gmap]
    #   @user.save
    # end
  end
  
  def set_user
    if params[:id]
      debug_log("[d] Users_Ctrl: index id: #{params[:id]}")  # log
      @user = User.find(params[:id])
    end
  end
end
