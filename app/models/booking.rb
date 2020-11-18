class Booking < ApplicationRecord
  belongs_to :user, presence: true
  belongs_to :service, presence: true
  belongs_to :pet, optional: true
end
