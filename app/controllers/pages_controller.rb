class PagesController < ApplicationController
  before_filter :authenticate_user
  def index
    if @current_user.id > 0
      redirect_to dashboard_path
    end
  end

  def dashboard
    @projects = Project.where(show_in_dashboard: true)

    if (params[:current_task_id])
      @current_task = Task.find(params[:current_task_id])
    end
  end
end
