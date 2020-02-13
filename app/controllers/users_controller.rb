class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
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
    if @user.save
      SendgridMailer.account_activation(@user).deliver_now
      # flash[:success]
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user = User.update(user_params)
      # flash[:success]
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :avatar)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
