class User < ApplicationRecord
  has_merit
  has_many :tosses
  has_many :places
  has_many :trash_bins
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
