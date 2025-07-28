class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, only: [:update, :toggle_suspend]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_suspend]

 

  def index
   # @users = User.all.order(created_at: :desc)
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end
  def edit
    # @user is already set by before_action
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to admin_index_path, notice: "User updated successfully." }
        format.turbo_stream
      end
    else
      redirect_to admin_index_path, alert: "Update failed."
    end
  end

  # Suspend / Unsuspend user toggle
  def toggle_suspend
    @user = User.find(params[:id])
    @user.suspended = !@user.suspended
    if @user.save
      status = @user.suspended ? "suspended" : "unsuspended"
      redirect_to admin_index_path, notice: "User successfully #{status}."
    else
      redirect_to admin_index_path, alert: "Failed to change suspend status."
    end
  end

  # Delete user
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_index_path, notice: "User deleted successfully."
    else
      redirect_to admin_index_path, alert: "Failed to delete user."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def set_user
  @user = User.find(params[:id])
end

  def ensure_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
