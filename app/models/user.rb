class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pets, :dependent => :destroy
  has_many :services, :dependent => :destroy
  has_many :bookings, :dependent => :destroy
  has_one_attached :picture, :dependent => :destroy
  has_one :address, :dependent => :destroy
  
  #I don't think a user will be able to not select a role - but just in case!!
  validates :is_nurse, inclusion: { in: [ true, false ], message: "You must select a role" }
  validates :fname, length: { in: 2..10, message: "must be between 2 and 10 characters"}
  validates :lname, length: { in: 2..10, message: "must be between 2 and 10 characters"}
end
