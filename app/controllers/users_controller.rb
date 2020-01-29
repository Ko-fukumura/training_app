class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to root_url
  end

  def edit
    @user = User.update(user_params)
  end

  def update
    @user = User.update(user_params)
    @user.save
    redirect_to root_url
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  private
  
    def user_params
      params.require(:users).permit(:name, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
