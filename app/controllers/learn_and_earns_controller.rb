class LearnAndEarnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_learn_and_earn, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: %i[new create]
  before_action :authorize_user_or_admin!, only: %i[edit update destroy]

  def index
    if current_user.admin?
      @learn_and_earns = LearnAndEarn.includes(:user).order(created_at: :desc)
      @users = User.all
    else
      @learn_and_earns = current_user.learn_and_earns.order(created_at: :desc)
    end
  end
  
  def track_click
    @learn_and_earn = LearnAndEarn.find(params[:id])
    @learn_and_earn.clicks.create!(user: current_user) # if you want to track user who clicked
    redirect_to @learn_and_earn.link
  end

  def show
  end

  def new
    @learn_and_earn = LearnAndEarn.new
  end

  def create
    @learn_and_earn = LearnAndEarn.new(learn_and_earn_params)
    @learn_and_earn.skip_proof_validation = true  # allow admin to skip proof validation
    #  @link = Link.find(params[:link_id])
    #@learn_and_earn = @link.learn_and_earn

    #Click.create!(user: current_user, link: @link, learn_and_earn: @learn_and_earn)


    respond_to do |format|
      if @learn_and_earn.save
        format.html { redirect_to learn_and_earns_path, notice: "Learn & Earn entry successfully created." }
        format.json { render :show, status: :created, location: @learn_and_earn }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @learn_and_earn.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.admin?
        if @learn_and_earn.update(learn_and_earn_params)
          format.html { redirect_to @learn_and_earn, notice: "Entry updated successfully." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      else
        if @learn_and_earn.update(user_proof_params)
          format.html { redirect_to @learn_and_earn, notice: "Proof submitted successfully." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @learn_and_earn.destroy

    respond_to do |format|
      format.html { redirect_to learn_and_earns_url, notice: "Learn & Earn entry successfully deleted.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_learn_and_earn
      @learn_and_earn = LearnAndEarn.find(params[:id])
    end

    def authorize_admin!
      redirect_to root_path, alert: "Admins only!" unless current_user.admin?
    end

    def authorize_user_or_admin!
      return if current_user.admin?
      redirect_to root_path, alert: "Access denied." unless @learn_and_earn.user == current_user
    end

    def learn_and_earn_params
      params.require(:learn_and_earn).permit(:user_id, :link, :social_post, :proof, :status)
    end

    def user_proof_params
      params.require(:learn_and_earn).permit(:proof)
    end
end
