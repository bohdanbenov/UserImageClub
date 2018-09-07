class Address < ApplicationRecord
  belongs_to :user

  validates_length_of :zip, is: 5,  message: "Zip must be 5 digit long"
  validates :city, :street, length: { maximum: 100, message: "Must be less than 100 characters" }
  validates_numericality_of :home_number, allow_nil: false,
                            only_integer: true, length: 5000, message: "Must be less than 5000 digits"
end
