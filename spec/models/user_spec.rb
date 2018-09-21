require 'rails_helper'

RSpec.describe User, type: :model do
  let(:first_name){'Ivan'}
  let(:last_name){'Petrov'}
  let(:user){User.new(first_name: first_name, last_name: last_name)}

  describe "#name" do
    context "when both present" do
      it 'returns first name and last name' do
        result = user.name
        expect(result).to eq('IvanPetrov')
      end
    end

    context "when first blank" do
      let(:first_name){''}
      let(:last_name){'Petrov'}

      it 'returns first name and last name' do
        result = user.name
        expect(result).to eq('Petrov')
      end
    end

    context "when last blank" do
      let(:first_name){'Ivan'}
      let(:last_name){''}

      it 'returns first name and last name' do
        result = user.name
        expect(result).to eq('Ivan')
      end
    end

    context "when both blank" do
      let(:first_name){''}
      let(:last_name){''}

      it 'returns first name and last name' do
        result = user.name
        expect(result).to eq('')
      end
    end
  end

  describe 'Validations' do
    context "when first_name not blank" do
      let(:user){build_stubbed(:user, first_name: '')}
      it "validates first_name presence" do
        expect(user).not_to be_valid
      end
    end

    context "when last_name not blank" do
      let(:user){build_stubbed(:user, last_name: '')}
      it "validates last_name presence" do
        expect(user).not_to be_valid
      end
    end

    context "when age is blank" do
      let(:user){build_stubbed(:user, age: 120)}
      it "validates blank age" do
        expect(user).to be_valid
      end
    end

    context "when about" do
      it "has range in 2..300 is valid" do
        expect(build_stubbed(:user, about: 'tt')).to be_valid
      end

      it "is blank is valid" do
        expect(build_stubbed(:user, about: '')).to be_valid
      end
    end

    context "when sex" do
      it "Female is valid" do
        expect(build_stubbed(:user, sex: 'Other')).to be_valid
      end
    end

    context "when address" do
      it "zip-code is valid" do
        expect(build_stubbed(:user, address_attributes: {zip: 71018})).to be_valid
      end

      it "city is valid" do
        expect(build_stubbed(:user, address_attributes: {city: 'Lviv'})).to be_valid
      end

      it "street is valid" do
        expect(build_stubbed(:user, address_attributes: {street: 'Luchakivska'})).to be_valid
      end

      it "home number is valid" do
        expect(build_stubbed(:user, address_attributes: {home_number: 500})).to be_valid
      end
    end
  end
end