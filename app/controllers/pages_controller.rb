class PagesController < ApplicationController
  before_filter :authenticate_user
  def index
    if @current_user.id > 0
      redirect_to dashboard_path
    end
  end

  def dashboard
    @projects = Project.all
  end
end
