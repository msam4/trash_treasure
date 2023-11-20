class TrashBin < ApplicationRecord
  belongs_to :place

  has_many :tosses

  validates :category, presence: true, inclusion: Item::CATEGORY
end
