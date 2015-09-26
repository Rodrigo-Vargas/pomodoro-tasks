class UsersController < ApplicationController
  before_filter :authenticate_user_admin, :only => [:edit]
  before_filter :save_login_state, :only => :new
  after_filter :save_login_state, :only => :create

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      
      redirect_to tasks_path
    else
      flash[:notice] = "Formulário com erros"
      flash[:color] = "invalid"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end