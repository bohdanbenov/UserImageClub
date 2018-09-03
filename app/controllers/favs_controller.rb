class FavsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @all_urls = Fav.where(user_id: params[:user_id]).order(:id)
  end
end