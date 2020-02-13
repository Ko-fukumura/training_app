class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: :create

  def new
  end

  def create
    # sessionでの実装
    # user = User.find_by(email: params[:session][:email])
    # if user && user.authenticate(params[:session][:password])
    #   session[:user_id] = user.id
    #   redirect_to root_path
    # else
    #   render :new
    # end

    # cookiesでの実装に変更
    if @user.authenticate(session_params[:password])
      sign_in(@user)
      redirect_to root_path
    else
      flash.now[:danger] = "invalid_password"
      render :new
    end
  end

  def destroy
    # sessionでの実装
    # session.delete(:user_id)
    # redirect_to login_path

    # cookiesでの実装に変更
    sign_out
    redirect_to login_path
  end
  
  private

    def set_user
      @user = User.find_by!(email: session_params[:email])
    rescue
      flash.now[:danger] = "invalid_email"
      render action: :new
    end

    def session_params
      params.require(:session).permit(:email, :password)
    end

end
