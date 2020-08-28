class StaticPagesController < ApplicationController
  def top
  end
  
  # 全国登録データ_種名、モルフ検索
  def search_page
    
    # 全国登録データ_検索フォーム
    if params[:searchtype] == "form"
      if params[:search].present?
        debug_log("[d] StaticPages_Ctrl: ac: search params_search=#{params[:search]}")  # log
        search_type_name = Reptile.where('type_name LIKE ?', "%#{params[:search]}%")
        search_morph = Reptile.where('morph LIKE ?', "%#{params[:search]}%")
        
        # 種別とモルフから検索
        if search_type_name.exists? || search_morph.exists?
          @search_result = search_type_name + search_morph
          flash.now[:warning] = "「#{params[:search]}」の検索結果：#{@search_result.count}件"
          
          debug_log("[d] StaticPages_Ctrl: ac: search search_type_name=#{search_type_name.inspect}")  # log
          debug_log("[d] StaticPages_Ctrl: ac: search search_morph=#{search_morph.inspect}")  # log
        else
          flash.now[:warning] = "「#{params[:search]}」の検索結果：0件"
        end
      else
        flash[:danger] = "値を入力してください。"
        redirect_to root_path
      end
    
    # 全国登録データ_種類から探す
    elsif params[:searchtype] == "ctg_btn"
      @type1_name = params[:type1]
      @search_type1_list = Reptile.where('type1 LIKE ?', "%#{params[:type1]}%")
      debug_log("[d] StaticPages_Ctrl: ac: search @search_type1=#{@search_type1_list.inspect}")  # log
      unless @search_type1_list.exists?
        flash.now[:warning] = "「#{params[:type1]}」の登録は現在ありません"
      end
    
    # 全国登録データ_選択レプタイル情報
    elsif params[:searchtype] == "reptileinfo"
      @disp_reptileinfo = Reptile.find(params[:id])
      debug_log("[d] StaticPages_Ctrl: ac: search @disp_reptileinfo=#{@disp_reptileinfo.inspect}")  # log
    
    # 全国登録データ_ショップ検索
    elsif params[:searchtype] == "shop_name"
      # 検索フォーム
      if @search_shop_name = params[:search]
        @search_shop_result = User.where('shop_name LIKE ?', "%#{params[:search]}%") #部分一致
        debug_log("[d] StaticPages_Ctrl: ac: search @search_shop_result=#{@search_shop_result.inspect}")  # log
        unless @search_shop_result.exists?
          flash.now[:warning] = "「#{params[:search]}」が該当するショップ名の登録は現在ありません"
        end
      # 都道府県から検索
      elsif @search_shop_prefectures = params[:prefectures]
        @search_shop_prefectures = User.where(prefectures: params[:prefectures]) #部分一致
        debug_log("[d] StaticPages_Ctrl: ac: search @prefectures=#{@search_shop_prefectures.inspect}")  # log
        unless @search_shop_prefectures.exists?
          flash.now[:warning] = "「#{params[:prefectures]}」で登録しているショップは現在ありません"
        end
      end
      
    # 全国登録データ_選択レプタイル_タイプからの検索フォーム
    else
      search_type_name = Reptile.where(type1: params[:searchtype], type_name: params[:search])
      search_morph = Reptile.where(type1: params[:searchtype], morph: params[:search])
      debug_log("[d] StaticPages_Ctrl: ac: search search_type_name=#{search_type_name.inspect}")  # log
      debug_log("[d] StaticPages_Ctrl: ac: search search_morph=#{search_morph.inspect}")  # log
      
      # 種別とモルフから検索
      if search_type_name.exists? || search_morph.exists?
        @search_result = search_type_name + search_morph
        flash.now[:warning] = "「#{params[:search]}」の検索結果：#{@search_result.count}件"
        
        debug_log("[d] StaticPages_Ctrl: ac: search search_type_name=#{search_type_name.inspect}")  # log
        debug_log("[d] StaticPages_Ctrl: ac: search search_morph=#{search_morph.inspect}")  # log
      else
        flash.now[:warning] = "「#{params[:search]}」の検索結果：0件"
      end
    end
  end
  
  # ショップページ
  def shop_page
    # ショップページ
    @disp_shopinfo = User.find(params[:shop_id])
    debug_log("[d] StaticPages_Ctrl: ac: shop_page @disp_shopinfo=#{@disp_shopinfo.inspect}")  # log
    @search_type1_list = "nodata"
    
    # レプタイル情報の表示
    if params[:type1].present?
      @type1_name = params[:type1]
      @search_type1_list = Reptile.where(type1: params[:type1], user_id: params[:shop_id])
      unless @search_type1_list.exists?
        flash.now[:warning] = "「#{params[:type1]}」の登録は現在ありません"
      end
    end
  end

end
