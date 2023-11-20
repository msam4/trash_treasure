class Place < ApplicationRecord
  has_many :trash_bins

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }

  has_many_attached :photos
end
