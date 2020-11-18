class Service < ApplicationRecord
    belongs_to :user
    validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000 }
    validates :description, presence: true, length: { in: 10..120, message: "Must be between 10 and 120 characters"}
    validates :name, presence: true, length: { in: 5..20, message: "Must be between 5 and 20 characters"}
end
