class User < ApplicationRecord
  has_many :images
  has_many :favs
  has_one :address
  accepts_nested_attributes_for :address
end
