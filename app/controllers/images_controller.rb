require 'faker'
require 'net/http'
require 'uri'

class ImagesController < ApplicationController

  before_action :set_user, only: [:index, :update, :destroy]
  before_action :check_access, only: [:index, :update, :destroy]

  def index
    faker = Faker::LoremFlickr.image
    first_part = faker.slice"http://loremflickr.com"
    second_part = get_response_with_redirect(URI.parse(faker))
    @url = first_part + second_part

    @user.images.create(image_url: @url)
    
    @all_urls = Image.where(user_id: params[:user_id]).order(:id)
  end

  def get_response_with_redirect(uri)
    r = Net::HTTP.get_response(uri)
    if r.code == "301"
      r = Net::HTTP.get_response(URI.parse(r.header['location']))
      part_url = r.header['location']
    end
    part_url
  end

  def update
    @user = User.find(params[:user_id])
    @img_record = Image.find(params[:id])
    @user.favs.create(url: @img_record.image_url)
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to user_images_path
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def check_access
    unless @user.id == current_user.id || current_user.is_admin?
      redirect_to root_path, :alert => "Access denied."
    end
    puts 'a'

    # unless @user == current_user
    #   redirect_to root_path, :alert => "Access denied."
    # end
  end
end
