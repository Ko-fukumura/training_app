class SessionsController < ApplicationController
  before_action :set_user, only: :create

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      if user.activated?
        log_in user
        session_params[:remember_me] == '1' ? remember(user) :  forget(user)
        redirect_back_or user
      else
        flash[:warning] = "Account not activated. Check your email for the activation link."
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
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
