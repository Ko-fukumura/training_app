class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @microposts = Micropost.all
  end

  def show
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new(micropost_params)
    @micropost.user_id = @user.id
    if @micropost.save
      # flash
      redirect_to microposts_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @micropost.update(micropost_params)
      # flash
      redirect_to @micropost
    else
      render :edit
    end
  end

  def destroy
    @micropost.delete
    redirect_to microposts_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :user_id)
    end

    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    def set_user
      @user = User.find_by(id: session[:user_id])
    end
end