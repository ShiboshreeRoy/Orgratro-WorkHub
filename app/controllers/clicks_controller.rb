class ClicksController < ApplicationController
  before_action :set_click, only: %i[ show edit update destroy ]

  # GET /clicks or /clicks.json
  def index
    @clicks = Click.all
  end

  # GET /clicks/1 or /clicks/1.json
  def show
  end

  # GET /clicks/new
  def new
    @click = Click.new
  end

  # GET /clicks/1/edit
  def edit
  end

  # POST /clicks or /clicks.json
  def create
    @click = Click.new(click_params)

    respond_to do |format|
      if @click.save
        format.html { redirect_to @click, notice: "Click was successfully created." }
        format.json { render :show, status: :created, location: @click }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @click.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clicks/1 or /clicks/1.json
  def update
    respond_to do |format|
      if @click.update(click_params)
        format.html { redirect_to @click, notice: "Click was successfully updated." }
        format.json { render :show, status: :ok, location: @click }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @click.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clicks/1 or /clicks/1.json
  def destroy
    @click.destroy!

    respond_to do |format|
      format.html { redirect_to clicks_path, status: :see_other, notice: "Click was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_click
      @click = Click.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def click_params
      params.require(:click).permit(:user_id, :link_id)
    end
end
