class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_credentials)

    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  private
    def user_credentials
      params.require(:user).permit(:name, :lastname, :email)
    end

end