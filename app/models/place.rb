class Place < ApplicationRecord
  has_many :trash_bins, dependent: :destroy

  geocoded_by :address #need to take the long/lat from photo to an address

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }
  after_validation :geocode, if :will_save_change_to_address?

  has_many_attached :photos
  end
end
