class UserTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_task, only: [:edit, :update, :approve]

  def index
    if current_user.admin?
      @user_tasks = UserTask.includes(:user, :task).order(created_at: :desc)
    else
      @user_tasks = current_user.user_tasks.includes(:task).order(created_at: :desc)
    end
  end

  def new
    @user_task = UserTask.new
  end

  def create
    # Automatically assign the logged-in user
    @user_task = UserTask.new(user_task_params.merge(user: current_user))
    if @user_task.save
      redirect_to user_tasks_path, notice: "Proof submitted successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to root_path, alert: "Access denied" unless @user_task.user == current_user
  end

  def update
    if @user_task.user == current_user && @user_task.update(user_task_params)
      redirect_to user_tasks_path, notice: "Proof submitted, waiting for approval."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def approve
    if current_user.admin?
      @user_task.update(approved: true)
      redirect_to user_tasks_path, notice: "Task approved!"
    else
      redirect_to root_path, alert: "Access denied"
    end
  end

  private

  def set_user_task
    @user_task = UserTask.find(params[:id])
  end

  def user_task_params
    params.require(:user_task).permit(:proof)
  end
end
