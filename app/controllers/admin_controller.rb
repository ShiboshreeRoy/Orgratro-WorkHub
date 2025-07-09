class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @users = User.all.order(created_at: :desc)
    
  end

 
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to admin_index_path, notice: "User updated successfully." }
        format.turbo_stream # for Hotwire/Turbo Streams (optional)
      end
    else
      redirect_to admin_index_path, alert: "Update failed."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def ensure_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
