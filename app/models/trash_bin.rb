class TrashBin < ApplicationRecord
  belongs_to :place

  has_many :tosses

  geocoded_by :address

  validates :category, presence: true, inclusion: { in: Item::CATEGORY }
  after_validation :geocode
end
