class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :images, dependent: :destroy
  has_many :favs, dependent: :destroy
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address, update_only: true

  validates_associated :address

  validates :first_name, :last_name, length: { maximum: 100, message: "Must be less than 100 characters" }
  validates_numericality_of :age, allow_nil: true, only_integer: true, less_than_or_equal_to: 120, message: "Must be in range from 0 to 120"
  validates :about, length: { maximum: 300, message: "Must be less than 300 characters" }
end
