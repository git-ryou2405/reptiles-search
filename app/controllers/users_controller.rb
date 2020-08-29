class UsersController < ApplicationController
  before_action :set_user, only:[:show]
  # require 'active_support'
  # require 'active_support/core_ext'
  # require 'open-uri'
  # require 'net/http'
  # require 'uri'
  # require 'json'

  def show
    debug_log("[d] Users_Ctrl: ac: show")  # log
    
    @show_option = "user"
    @current_reptile = Reptile.where(user_id: current_user)
    
    # ショップが持つ、新入荷レプタイル情報を取得
    if @current_reptile
      @created_at_desc = @current_reptile.all.order(created_at: "DESC")  # 降順
      debug_log("[d] Users_Ctrl: ac: show @created_at_desc.count=#{@created_at_desc.count}")  # log
      
      if @created_at_desc.count <= 5
        @new_arrivals = @created_at_desc.first(@created_at_desc.count)
      else
        @new_arrivals = @created_at_desc.first(5)
      end
      debug_log("[d] Users_Ctrl: ac: show @new_arrivals=#{@new_arrivals.inspect}")  # log
      debug_log("[d] Users_Ctrl: ac: show @new_arrivals.count=#{@new_arrivals.count}")  # log
    end
    
    # ショップが持つ、タイプ毎のReptile情報を取得
    if params[:reptile_type].present?
      @show_option = params[:reptile_type]
      @reptile_type = @current_reptile.where(type1: params[:reptile_type])
      debug_log("[d] Users_Ctrl: ac: show @show_option=#{@reptile_type}")  # log
      unless @reptile_type.present?
        flash.now[:warning] = "「#{params[:reptile_type]}」の登録は現在ありません"
      end
    end
    
    # 新入荷から選択したレプタイルページへ遷移
    if params[:new_regist].present?
      @show_option = params[:new_regist]
      @new_regist_reptile = @current_reptile.find(params[:new_regist])
      debug_log("[d] Users_Ctrl: ac: show @new_regist_reptile=#{@new_regist_reptile}")  # log
    end
    
    debug_log("[d] Users_Ctrl: ac: show @show_option=#{@show_option}")  # log
  end
  
  # ショップidを取得
  def set_user
    if params[:id]
      debug_log("[d] Users_Ctrl: ac: set_user id=#{params[:id]}")  # log
      @user = User.find(params[:id])
    end
  end
end
