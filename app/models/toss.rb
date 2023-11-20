class Toss < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :trash_bin
end
