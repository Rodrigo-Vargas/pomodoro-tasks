class ProjectsController < ApplicationController
  before_filter :authenticate_user

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save 
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to dashboard_path
    else 
      render 'edit'
    end
  end

  private
    def project_params
      params.require(:project).permit(:title, :title_slug)
    end
end
