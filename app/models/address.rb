class Address < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  before_save :update_address


  ## In future, look at SmartyStreets to validate & autocomplete address?
  validates :street, presence: true, length: { in: 2..50, message: "Must be between 2 and 50 characters"}
  validates :suburb, presence: true, length: { in: 2..30, message: "Must be between 2 and 30 characters"}
  validates :state, inclusion: { in: ['NSW', 'VIC', 'QLD', 'SA', 'TAS', 'WA']} 

  # This method ensures that geocode is run every time the address is updated
  def update_address
    self.address = "#{self.suburb}, #{self.state}"
    geocode
  end

end
