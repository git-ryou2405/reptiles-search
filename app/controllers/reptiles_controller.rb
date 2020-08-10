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
    @reptile.user_id = current_user.id
    debug_log("[d] Reptiles_Ctrl: @reptile: #{@reptile.inspect}")  # log

    respond_to do |format|
      if @reptile.save
        format.html { redirect_to user_url(@reptile.user_id), notice: 'Reptile was successfully created.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reptile
      @reptile = Reptile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reptile_params
      params.require(:reptile).permit(:aname, :image, :tyep1, :tyep2, :sex, :size, :max, :area, :description, :price, :sales_status, :arrival_day)
    end
end
