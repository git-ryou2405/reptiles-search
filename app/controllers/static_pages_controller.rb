class StaticPagesController < ApplicationController
  def top
  end
  
  # 全国Data_種名、モルフ検索
  def search_page
  
    # 全国Data_新入荷レプタイル情報を取得
    if Reptile.all
      @created_at_desc = Reptile.all.order(created_at: "DESC")  # 降順
      debug_log("[d] StaticPages_Ctrl: ac: search_page @created_at_desc.count=#{@created_at_desc.count}")  # log
      
      if @created_at_desc.count <= 5
        @new_arrivals = @created_at_desc.first(@created_at_desc.count)
      else
        @new_arrivals = @created_at_desc.first(5)
      end
      debug_log("[d] StaticPages_Ctrl: ac: search_page @new_arrivals=#{@new_arrivals.inspect}")  # log
      debug_log("[d] StaticPages_Ctrl: ac: search_page @new_arrivals.count=#{@new_arrivals.count}")  # log
    end
    
    # 全国Data_検索フォーム
    if params[:searchtype] == "form"
      if params[:search].present?
        debug_log("[d] StaticPages_Ctrl: ac: search_page params_search=#{params[:search]}")  # log
        search_type_name = Reptile.where('type_name LIKE ?', "%#{params[:search]}%")
        search_morph = Reptile.where('morph LIKE ?', "%#{params[:search]}%")
        
        # 種別とモルフから検索
        if search_type_name.exists? || search_morph.exists?
          @search_result = search_type_name + search_morph
          flash.now[:warning] = "「#{params[:search]}」の検索結果：#{@search_result.count}件"
          
          debug_log("[d] StaticPages_Ctrl: ac: search_page search_type_name=#{search_type_name.inspect}")  # log
          debug_log("[d] StaticPages_Ctrl: ac: search_page search_morph=#{search_morph.inspect}")  # log
        else
          flash.now[:warning] = "「#{params[:search]}」の検索結果：0件"
        end
      else
        flash[:danger] = "値を入力してください。"
        redirect_to root_path
      end
    
    # 全国Data_種類から探す
    elsif params[:searchtype] == "ctg_btn"
      @type1_name = params[:type1]
      @search_type1_list = Reptile.where('type1 LIKE ?', "%#{params[:type1]}%")
      debug_log("[d] StaticPages_Ctrl: ac: search_page @search_type1=#{@search_type1_list.inspect}")  # log
      unless @search_type1_list.exists?
        flash.now[:warning] = "「#{params[:type1]}」の登録は現在ありません"
      end
    
    # 全国Data_選択したレプタイル情報
    elsif params[:searchtype] == "reptile_info"
      @select_reptile = Reptile.find(params[:id])
      debug_log("[d] StaticPages_Ctrl: ac: search_page @select_reptile=#{@select_reptile.inspect}")  # log
    
    # 全国Data_ショップ検索
    elsif params[:searchtype] == "shop_name"
      # 検索フォーム
      if @search_shop_name = params[:search]
        @search_shop_result = User.where('shop_name LIKE ?', "%#{params[:search]}%") #部分一致
        debug_log("[d] StaticPages_Ctrl: ac: search_page @search_shop_result=#{@search_shop_result.inspect}")  # log
        unless @search_shop_result.exists?
          flash[:warning] = "「#{params[:search]}」が該当するショップ名の登録は現在ありません"
          redirect_to root_path
        end
      # 都道府県から検索
      elsif @search_shop_prefectures = params[:prefectures]
        @search_shop_prefectures = User.where(prefectures: params[:prefectures]) #部分一致
        debug_log("[d] StaticPages_Ctrl: ac: search_page @prefectures=#{@search_shop_prefectures.inspect}")  # log
        unless @search_shop_prefectures.exists?
          flash[:warning] = "「#{params[:prefectures]}」で登録しているショップは現在ありません"
          redirect_to root_path
        end
      end
      
    # 全国Data_選択したレプタイル_type1から検索
    else
      search_type1 = Reptile.where(type1: params[:searchtype])
      search_type_name = search_type1.where('type_name like ?',"%#{params[:search]}%")
      search_morph = search_type1.where('morph like ?',"%#{params[:search]}%")
      debug_log("[d] StaticPages_Ctrl: ac: search_page search_type_name=#{search_type_name.inspect}")  # log
      debug_log("[d] StaticPages_Ctrl: ac: search_page search_morph=#{search_morph.inspect}")  # log
      
      # 種別とモルフから検索
      if search_type_name.exists? || search_morph.exists?
        @search_result = search_type_name + search_morph
        flash.now[:warning] = "「#{params[:search]}」の検索結果：#{@search_result.count}件"
        
        debug_log("[d] StaticPages_Ctrl: ac: search_page search_type_name=#{search_type_name.inspect}")  # log
        debug_log("[d] StaticPages_Ctrl: ac: search_page search_morph=#{search_morph.inspect}")  # log
      else
        flash.now[:warning] = "「#{params[:search]}」の検索結果：0件"
      end
    end
  end
  
  # ショップページ
  def shop_page
    # ショップ情報を取得
    @disp_shopinfo = User.find(params[:shop_id])
    @search_cate = "nodata"
    
    # レプタイル情報を取得
    @shop_reptile = Reptile.where(user_id: params[:shop_id])
    
    # ショップ内_新入荷レプタイル情報を取得
    if @shop_reptile
      @created_at_desc = @shop_reptile.all.order(created_at: "DESC")  # 降順
      debug_log("[d] StaticPages_Ctrl: ac: shop_page @created_at_desc.count=#{@created_at_desc.count}")  # log
      
      if @created_at_desc.count <= 5
        @new_arrivals = @created_at_desc.first(@created_at_desc.count)
      else
        @new_arrivals = @created_at_desc.first(5)
      end
    end
    
    # ショップ内_レプタイル検索
    if params[:search].present?
      @search_cate = "search_shop_reptile"
      search_type_name = @shop_reptile.where('type_name like ?', "%#{params[:search]}%")
      search_morph = @shop_reptile.where('morph like ?', "%#{params[:search]}%")
      @shop_search_reptile = search_type_name + search_morph
      debug_log("[d] StaticPages_Ctrl: ac: shop_page @shop_search_reptile=#{@shop_search_reptile}")  # log
      
      unless @shop_search_reptile.present?
        flash.now[:warning] = "「#{params[:search]}」の検索結果：0件"
      end
    end
    
    # ショップ内_レプタイル_type1選択
    if params[:type1].present?
      @search_cate = "type1"
      @shop_reptile_type1 = Reptile.where(type1: params[:type1], user_id: params[:shop_id])
      debug_log("[d] StaticPages_Ctrl: ac: shop_page @shop_reptile_type1=#{@shop_reptile_type1}")  # log
      
      @type1_name = params[:type1]
      unless @shop_reptile_type1.exists?
        flash.now[:warning] = "「#{params[:type1]}」の登録は現在ありません"
      end
    end
    
    # ショップ内_選択したレプタイル情報
    if params[:reptile_id].present?
      @search_cate = "reptile_info"
      @select_reptile = @shop_reptile.find(params[:reptile_id])
    end
  end

end
