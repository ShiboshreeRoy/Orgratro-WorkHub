class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :check_non_admin_access, only: [:index]
  before_action :set_task, only: [:show, :edit, :update, :destroy, :send_to_all]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge(user:current_user))
    #@task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "✅ Task created successfully."
    else
      flash.now[:alert] = "❌ Failed to create task."
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "✅ Task updated successfully."
    else
      flash.now[:alert] = "❌ Failed to update task."
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "🗑️ Task deleted successfully."
  end

  def send_to_all
    User.find_each do |user|
      UserTask.find_or_create_by(user: user, task: @task)
    end
    redirect_to tasks_path, notice: "📢 Task sent to all users!"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name, :task_type, :link, :description, :user_id)
  end

  def require_admin!
    redirect_to root_path, alert: "⛔ Access denied" unless current_user.admin?
  end
end
