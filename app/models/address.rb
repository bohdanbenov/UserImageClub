class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates_length_of :zip, is: 5,  message: "Zip must be 5 digit long"
  validates :city, :street, length: { in: 1..100, message: "Must be less than 100 characters" }, allow_blank: false
  validates_numericality_of :home_number, allow_nil: false,
                            only_integer: true, greater_than: 0, less_than: 5000, message: "Must be less than 5000 digits"
end