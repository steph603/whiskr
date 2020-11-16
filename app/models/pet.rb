class Pet < ApplicationRecord
    belongs_to :user
    has_one_attached :picture
    has_many :bookings
end
