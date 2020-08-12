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
    
    @reptile_list = "user"
    
    if params[:type1].present?
      debug_log("[d] Users_Ctrl: action: show reptile_list = #{params[:type1]}")  # log
      @reptile_list = params[:type1]
      
      @aa = User.where(id: Reptile.where(type1: params[:type1]).select(current_user.id))
      debug_log("[d] Users_Ctrl: action: show @reptile_list = #{@aa}")  # log
    end
    debug_log("[d] Users_Ctrl: action: show @reptile_list = #{@reptile_list}")  # log
    
    
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
