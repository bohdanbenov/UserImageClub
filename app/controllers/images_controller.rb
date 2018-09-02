require 'faker'
require 'net/http'
require 'uri'

class ImagesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    faker = Faker::LoremFlickr.image
    first_part = faker.slice"http://loremflickr.com"
    second_part = get_response_with_redirect(URI.parse(faker))
    @url = first_part + second_part

    @user.images.create(image_url: @url)
  end

  def get_response_with_redirect(uri)
    r = Net::HTTP.get_response(uri)
    if r.code == "301"
      r = Net::HTTP.get_response(URI.parse(r.header['location']))
      part_url = r.header['location']
    end
    part_url
  end
end
