class Picture < ApplicationRecord
  validates :image, presence: true
  belongs_to :user
end
