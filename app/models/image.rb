class Image < ApplicationRecord
  belongs_to :user, optional: true
end
