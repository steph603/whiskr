class Address < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  before_save :update_address

  def update_address
    self.address = "#{self.suburb}, #{self.state}"
    geocode
  end

end
