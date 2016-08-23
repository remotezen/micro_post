class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only:[:destroy]
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created, atta go!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:info] = "micropost destroyed"
    redirect_back(fallback_location: root_url)
  end

  private

  def correct_user
    #Make sure to search user microposts for the correct id
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?

  end

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end
end

