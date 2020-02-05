class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]

  def index
    @microposts = Micropost.all
  end

  def show
  end

  def new
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
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
      params.require(:micropost).permit(:content, images: [])
    end

    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

end