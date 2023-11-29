class Place < ApplicationRecord
  has_many :trash_bins, dependent: :destroy
  has_many :tosses, through: :trash_bins

  geocoded_by :name #need to take the long/lat from photo to an address

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }
  after_validation :geocode, if: :will_save_change_to_name?

  has_many_attached :photos

  belongs_to :user
end
