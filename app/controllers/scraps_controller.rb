class ScrapsController < ApplicationController
  before_action :set_scrap, only: [:show, :edit, :update, :destroy]

  # GET /scraps
  # GET /scraps.json
  def index
    @scraps = Scrap.all
  end

  # GET /scraps/1
  # GET /scraps/1.json
  def show
  end

  # GET /scraps/new
  def new
    @scrap = Scrap.new
  end

  # GET /scraps/1/edit
  def edit
  end

  # POST /scraps
  # POST /scraps.json
  def create
    @scrap = Scrap.new(scrap_params)
    @scrap.initial_finish = @scrap.finish
    @scrap.last_start = @scrap.start
    respond_to do |format|
      if @scrap.save
        @scrap.do_scrap
        format.html { redirect_to @scrap, notice: 'Scrap was successfully created.' }
        format.json { render :show, status: :created, location: @scrap }
      else
        format.html { render :new }
        format.json { render json: @scrap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scraps/1
  # PATCH/PUT /scraps/1.json
  def update
    respond_to do |format|
      if @scrap.update(scrap_params)
        format.html { redirect_to @scrap, notice: 'Scrap was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrap }
      else
        format.html { render :edit }
        format.json { render json: @scrap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scraps/1
  # DELETE /scraps/1.json
  def destroy
    @scrap.destroy
    respond_to do |format|
      format.html { redirect_to scraps_url, notice: 'Scrap was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrap
      @scrap = Scrap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrap_params
      params.require(:scrap).permit(:start, :finish, :external_id)
    end
end
