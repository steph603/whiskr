class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :service
  belongs_to :pet, optional: true
end
