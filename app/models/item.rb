class Item < ApplicationRecord

  CATEGORY = {
    "PET bottle" => "pet_bottle.png",
    "can" => "can.png",
    "glass" => "glass.png",
    "burnables" => "burnables.png",
    "non-burnables" => "non_burnables.png",
    "paper" => "paper.png",
    "plastic" => "plastic.png"
  }

  validates :category, presence: true, inclusion: { in: CATEGORY }
end
