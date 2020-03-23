class TasksController < ApplicationController
  before_action :login_or
  before_action :set_authentication, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: "DESC")
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "投稿しました。"
      else
        render :new
      end
    end
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to tasks_url, notice: "更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:content, :name, :image)
  end

  def set_authentication
    @task = Task.find(params[:id])
    unless current_user == @task.user
      redirect_to tasks_path, notice: "ユーザーが違います"
    end
  end

  def login_or
    unless logged_in? then
      redirect_to new_session_url
    end
  end
end
