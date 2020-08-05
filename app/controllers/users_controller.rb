class UsersController < ApplicationController
  
  def show
    debug_log("[debug] action: index")  # デバッグ出力
    
    if params[:id]
      debug_log("[debug] index id: #{params[:id]}")  # デバッグ出力
      @user = User.find(params[:id])
    end
  end
end
