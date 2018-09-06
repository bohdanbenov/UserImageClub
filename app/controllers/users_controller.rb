class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.address = Address.new
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
      params.require(:user).permit(:first_name, :last_name, :email, :age, :sex, :about,
                                   address_attributes: [:zip, :city, :street, :home_number])
    end


end