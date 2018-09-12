require 'faker'
require 'net/http'
require 'uri'

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :check_access, only: [:edit, :update, :destroy, :show]

  def index
    @users = User.all
    @user = current_user
    @all_urls = []

    if current_user == nil
      12.times do |x|
        faker = Faker::LoremFlickr.image
        first_part = faker.slice"http://loremflickr.com"
        second_part = get_response_with_redirect(URI.parse(faker))
        url = first_part + second_part
        @all_urls << url
      end
    end

    if params.has_key?(:sort_by_names) && params.has_value?("1")
      @users = User.all.order(first_name: :asc)
    elsif params.has_key?(:sort_by_names) && params.has_value?("2")
      @users = User.all.order(last_name: :asc)
    end

    @addr = Address.all.order(city: :asc).uniq.pluck(:city)

    if params.has_key?(:sort_by_cities)
      @users = @users.joins(:address).includes(:address).where("addresses.city = ?", params.values_at(:sort_by_cities)[0])
    end

    if params.has_key?(:Male)
      @users = User.where("sex = :sex", {sex: "Male"})
    elsif params.has_key?(:Female)
      @users = User.where("sex = :sex", {sex: "Female"})
    elsif params.has_key?(:Other)
      @users = User.where("sex = :sex", {sex: "Other"})
    end

    if params.has_key?(:from) && params.has_key?(:to)
      @users = User.where("age BETWEEN ? AND ?", params.values_at(:from)[0], params.values_at(:to)[0]).order(age: :asc)
    end

  end

  def get_response_with_redirect(uri)
    r = Net::HTTP.get_response(uri)
    if r.code == "301"
      r = Net::HTTP.get_response(URI.parse(r.header['location']))
      part_url = r.header['location']
    end
    part_url
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

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_credentials)
        format.html { redirect_to user_images_path(@user.id), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def check_access
      unless @user == current_user || current_user.is_admin?
        redirect_to root_path, :alert => "Access denied."
      end
    end

    def user_credentials
      params.require(:user).permit(:first_name, :last_name, :email, :age, :sex, :about,
                                   address_attributes: [:zip, :city, :street, :home_number])
    end


end