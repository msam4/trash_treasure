class Item < ApplicationRecord
  belongs_to :toss

  CATEGORY = ["PET bottle", "can", "glass", "burnables", "non-burnables", "paper", "plastic"]

  validates :category, presence: true, inclusion: CATEGORY
end
