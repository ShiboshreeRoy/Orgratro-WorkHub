class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!
  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, only: [:update, :toggle_suspend]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_suspend]

  # Dashboard / Users list
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc)
  end

  # Show individual user
  def show
    # @user is already set by set_user
  end

  # New user form handled in index view
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_index_path, notice: "User created successfully."
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true)
      render "admin/index"
    end
  end

  # Edit user form handled in index view
  def edit
    # @user is already set by set_user
  end

  # Update user attributes
  def update
    if @user.update(user_update_params)
      respond_to do |format|
        format.html { redirect_to admin_index_path, notice: "User updated successfully." }
        format.turbo_stream
      end
    else
      redirect_to admin_index_path, alert: @user.errors.full_messages.join(", ")
    end
  end

  # Toggle suspend/unsuspend user
  def toggle_suspend
    @user.suspended = !@user.suspended
    if @user.save
      status = @user.suspended ? "suspended" : "unsuspended"
      redirect_to admin_index_path, notice: "User successfully #{status}."
    else
      redirect_to admin_index_path, alert: "Failed to change suspend status."
    end
  end

 def destroy
  if @user.destroy
    redirect_to admin_index_path, notice: "User deleted successfully."
  else
    redirect_to admin_index_path, alert: "Failed to delete user."
  end
 end


  private

  # Only permit the allowed attributes for create
  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end

  # Permit attributes for update (conditionally include password)
  def user_update_params
    permitted = [:email, :role]
    if params[:user][:password].present?
      permitted += [:password, :password_confirmation]
    end
    params.require(:user).permit(permitted)
  end

  # Set user for actions
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow admins
  def ensure_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
