class UsersController < ApplicationController
  before_action :set_user, only:[:show]
  # require 'active_support'
  # require 'active_support/core_ext'
  # require 'open-uri'
  # require 'net/http'
  # require 'uri'
  # require 'json'

  def show
    
    
    @areptyle_all = Reptile.all
    @user_reptile = Reptile.where(user_id: @user.id)
    @reptile_type1 = Reptile.group(:type1)
    
    debug_log("[d] Users_Ctrl: action: show")  # log
    
    @show_option = "user"
    
    if params[:reptile_type].present?
      debug_log("[d] Users_Ctrl: action: show reptile_list = #{params[:reptile_type]}")  # log
      @show_option = params[:reptile_type]
      
      @user_reptile = User.where(id: Reptile.where(type1: params[:reptile_type]).select(current_user.id))
      debug_log("[d] Users_Ctrl: action: show @user_reptile = #{@user_reptile}")  # log
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
