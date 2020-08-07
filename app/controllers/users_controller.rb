class UsersController < ApplicationController
  before_action :set_user, only:[:show]
  
  def show
    debug_log("[d] Users_Ctrl: action: index")  # デバッグ出力
  end
  
  def set_user
    if params[:id]
      debug_log("[d] Users_Ctrl: index id: #{params[:id]}")  # デバッグ出力
      @user = User.find(params[:id])
    end
  end
  
end
