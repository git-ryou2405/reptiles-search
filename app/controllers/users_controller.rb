class UsersController < ApplicationController
  before_action :set_user, only:[:show]
  # require 'active_support'
  # require 'active_support/core_ext'
  # require 'open-uri'
  # require 'net/http'
  # require 'uri'
  # require 'json'

  def show
    debug_log("[d] Users_Ctrl: action: index")  # log
    
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
