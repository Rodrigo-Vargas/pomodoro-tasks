class TasksController < ApplicationController
  before_filter :authenticate_user

  def index
    @done_tasks = Task.where('completed_at is not null')
    @undone_tasks = Task.where('completed_at is null')
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def complete
    @task = Task.find(params[:id])
    
    if (params[:task][:isCompleted] == "1")
      @task.completed_at = Date.current()
    else
      @task.completed_at = nil
    end

    @task.save

    redirect_to tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:title)
    end
end
