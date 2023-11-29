class TrashBin < ApplicationRecord
  belongs_to :place

  has_many :tosses

  attribute :is_present, :boolean

  # geocoded_by :address

  validates :category, presence: true, inclusion: { in: Item::CATEGORY }
  # after_validation :geocode

  belongs_to :user
end
