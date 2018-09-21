require 'rails_helper'

RSpec.describe "Favourites", type: :request do
  # let!(:image){create(:image)}
  let!(:user){create(:user, password: '123456')}

  before do
    post '/login', params: {
                              user: {
                                email: user.email,
                                password: "123456"
                              }
                            }
  end

  describe '#create' do
    it "add to favourites" do
      expect{put("/users/#{ user.id }/images/12")}.to change{Fav.where(user_id: user.id, url: image.image_url).count}.from(0).to(1)
    end
  end

  describe '#destroy' do
    let!(:image){create(:image, user_id: user.id)}
    it "delete from images" do
      expect{delete("/users/#{ user.id }/images/#{image.id}")}.to change{Image.where(id: image.id).count}.from(1).to(0)
    end
  end

  describe "#index favourites" do
    before do
      get user_favs_path(user_id: user.id)
    end

    it "succeeds" do
      expect(response.status).to eq(200)
    end
  end
end
