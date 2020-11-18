class Pet < ApplicationRecord
    belongs_to :user
    has_one_attached :picture
    has_many :bookings
    validates :name, length: { in: 2..10, message: "Must be between 2 and 10 characters"}
    validates :species, inclusion: { in: ['Cat', 'Dog']} 
end
