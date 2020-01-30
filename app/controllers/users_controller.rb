class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to root_url
  end

  def edit
    
  end

  def update
    @user = User.update(user_params)
    redirect_to user_url(@user)
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
