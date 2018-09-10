class FavsController < ApplicationController
  before_action :check_access, only: [:index]
  def index
    @user = User.find(params[:user_id])
    @all_urls = Fav.where(user_id: params[:user_id]).order(:id)
  end

  private
  def check_access
    unless @user == current_user || current_user.is_admin?
      redirect_to root_path, :alert => "Access denied."
    end
  end
end