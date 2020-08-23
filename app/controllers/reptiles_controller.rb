class ReptilesController < ApplicationController
  # before_action :set_user, only: [:new, :index, :show, :edit, :create, :update, :destroy]
  before_action :set_reptile, only: [:show, :edit, :update, :destroy]

  # GET /reptiles
  # GET /reptiles.json
  def index
    @reptiles = Reptile.all
  end

  # GET /reptiles/1
  # GET /reptiles/1.json
  def show
  end

  # GET /reptiles/new
  def new
    debug_log("[d] Reptiles_Ctrl: action: new")  # log
    @reptile = Reptile.new
    debug_log("[d] Reptiles_Ctrl: @reptile: #{@reptile.inspect}")  # log
  end

  # GET /reptiles/1/edit
  def edit
  end

  # POST /reptiles
  # POST /reptiles.json
  def create
    debug_log("[d] Reptiles_Ctrl: action: create")  # log
    @reptile = Reptile.new(reptile_params)
    
    @reptile.shop_name = current_user.shop_name
    @reptile.user_id = current_user.id
    debug_log("[d] Reptiles_Ctrl: @reptile: #{@reptile.inspect}")  # log

    respond_to do |format|
      if @reptile.save
        format.html { redirect_to user_url(@reptile.user_id), notice: "種名：\"#{@reptile.type_name}\"を登録しました。" }
        format.json { render :show, status: :created, location: @reptile }
      else
        format.html { render :new }
        format.json { render json: @reptile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reptiles/1
  # PATCH/PUT /reptiles/1.json
  def update
    respond_to do |format|
      if @reptile.update(reptile_params)
        format.html { redirect_to @reptile, notice: 'Reptile was successfully updated.' }
        format.json { render :show, status: :ok, location: @reptile }
      else
        format.html { render :edit }
        format.json { render json: @reptile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reptiles/1
  # DELETE /reptiles/1.json
  def destroy
    @reptile.destroy
    respond_to do |format|
      format.html { redirect_to reptiles_url, notice: 'Reptile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # 全国登録データ_種名、モルフ検索
  def search_page
    
    # 全国登録データ_検索フォーム
    if params[:searchtype] == "form"
      if params[:search].present?
        debug_log("[d] Reptiles_Ctrl: ac: search params_search=#{params[:search]}")  # log
        search_type_name = Reptile.where('type_name LIKE ?', "%#{params[:search]}%")
        search_morph = Reptile.where('morph LIKE ?', "%#{params[:search]}%")
        
        # 種別とモルフから検索
        if search_type_name.exists? || search_morph.exists?
          @search_result = search_type_name + search_morph
          flash.now[:warning] = "「#{params[:search]}」の検索結果：#{@search_result.count}件"
          
          debug_log("[d] Reptiles_Ctrl: ac: search search_type_name=#{search_type_name.inspect}")  # log
          debug_log("[d] Reptiles_Ctrl: ac: search search_morph=#{search_morph.inspect}")  # log
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
      debug_log("[d] Reptiles_Ctrl: ac: search @search_type1=#{@search_type1_list.inspect}")  # log
      unless @search_type1_list.exists?
        flash.now[:warning] = "「#{params[:type1]}」の登録は現在ありません"
      end
    
    # 全国登録データ_選択レプタイル情報
    elsif params[:searchtype] == "reptileinfo"
      @disp_reptileinfo = Reptile.find(params[:id])
      debug_log("[d] Reptiles_Ctrl: ac: search @disp_reptileinfo=#{@disp_reptileinfo.inspect}")  # log
    
    # 全国登録データ_選択レプタイル_タイプからの検索フォーム
    else
      search_type_name = Reptile.where(type1: params[:searchtype], type_name: params[:search])
      search_morph = Reptile.where(type1: params[:searchtype], morph: params[:search])
      debug_log("[d] Reptiles_Ctrl: ac: search search_type_name=#{search_type_name.inspect}")  # log
      debug_log("[d] Reptiles_Ctrl: ac: search search_morph=#{search_morph.inspect}")  # log
      
      # 種別とモルフから検索
      if search_type_name.exists? || search_morph.exists?
        @search_result = search_type_name + search_morph
        flash.now[:warning] = "「#{params[:search]}」の検索結果：#{@search_result.count}件"
        
        debug_log("[d] Reptiles_Ctrl: ac: search search_type_name=#{search_type_name.inspect}")  # log
        debug_log("[d] Reptiles_Ctrl: ac: search search_morph=#{search_morph.inspect}")  # log
      else
        flash.now[:warning] = "「#{params[:search]}」の検索結果：0件"
      end
    end
  end
  
  # ショップページ
  def shop_page
    @disp_shopinfo = User.find(params[:shop_id])
    @search_type1_list = "nodata"
    
    # レプタイル情報
    if params[:type1].present?
      @type1_name = params[:type1]
      @search_type1_list = Reptile.where(type1: params[:type1], user_id: params[:shop_id])
      unless @search_type1_list.exists?
        flash.now[:warning] = "「#{params[:type1]}」の登録は現在ありません"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reptile
      @reptile = Reptile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reptile_params
      params.require(:reptile).permit( {images: []}, :type1, :type2, :type_name, :morph, :sex, :age, :size, :weight, :description, :price, :sales_status, :arrival_day, :shop_name )
    end
end
