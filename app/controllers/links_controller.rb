class LinksController < ApplicationController
  before_action :authenticate_user!
  # Ensure user is admin for create, update, destroy actions
  #before_action :authorize_admin!, only: %i[ new create edit update destroy ]
  # Set link for show, edit, update, destroy actions
  before_action :set_learn_and_earn, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = Link.all
  end

  # GET /links/1 or /links/1.json
  def show
    @link = Link.find(params[:id])
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  def click_window
  @url = params[:url]
  render layout: false
end
  # POST /links or /links.json
  '''def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end
'''

def create
    @link = Link.new(link_params)
    @link.user = current_user
    @link.learn_and_earn = @learn_and_earn if @learn_and_earn

    if @link.save
      redirect_to links_path, notice: "Link was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


# click action to handle link clicks
  # POST /click_link/:id
  # This action records a click on a link by the current user
 def click
    @link = Link.find(params[:id])

    # Prevent duplicate clicks in 24 hours
    already_clicked = Click.exists?(user: current_user, link: @link, created_at: 24.hours.ago..Time.now)

    if already_clicked
      redirect_to links_path, alert: "You already clicked this link today."
    else
      Click.create!(user: current_user, link: @link)
      @link.increment!(:total_clicks)
      current_user.increment!(:balance, 0.000333333333)
      redirect_to links_path, notice: "Click recorded. You earned $0.0.000333333333!"
    end
  end

  

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_path, status: :see_other, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learn_and_earn
    @learn_and_earn = LearnAndEarn.find_by(id: params[:learn_and_earn_id]) || LearnAndEarn.first
  end


    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url, :total_clicks, :user_id, :learn_and_earn_id)
    end
end
