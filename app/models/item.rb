class Item < ApplicationRecord

  CATEGORY = ["PET bottle", "can", "glass", "burnables", "non-burnables", "paper", "plastic"]

  validates :category, presence: true, inclusion: CATEGORY
end
