require 'rails_helper'

RSpec.describe "Images", type: :request do
  describe "#index" do
    before do
      get root_path
    end

    it "succeeds" do
      expect(response).to be_ok
    end

    it "failure 400" do
      expect(response.status).to eq(400)
    end

    it "renders index" do
      expect(response).to render_template("users/index")
    end



    it "displays all pictures" do

    end
  end
end