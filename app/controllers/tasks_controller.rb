class TasksController < ApplicationController
  before_filter :authenticate_user

  def index
    @project = Project.find(params[:project_id])

    @done_tasks = @project.tasks.where('completed_at is not null')
    @undone_tasks = @project.tasks.where('completed_at is null')
  end

  def show

  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new(project: @project)
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)

    if @task.save
      redirect_to project_tasks_path(params[:project_id])
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      redirect_to project_tasks_path(@task.project)
    else 
      render 'edit'
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

    redirect_to dashboard_path
  end

  private
    def task_params
      params.require(:task).permit(:title)
    end
end
