class PagesController < ApplicationController
  before_action :set_user, only: [:profile]



  def set_user
    @user = User.find(params[:id])
  end
  
  def home
  end

  def checkout
    @all_bookings = Booking.all
    @lines = []

    @all_bookings.each { |b|
      if b.user_id == current_user.id
      @lines << b 
      end
      }
      
  end

  # This method returns nurses within 20km(?) of the suburb searched for
  def find
    @matches = []
    Address.near(params[:search]).each { |address| 
      @matches << address.user_id
    }
    @nurses = []
    @users = User.all
    @matches.each { |match| 
      @users.each { |user|
      if user.is_nurse && user.id == match
      @nurses << user
      end  } 
    }
  end
  
  def profile
  end

  def my_profile
    @user = current_user
    @address = current_user.address
  end

  #I don't think I need this, but saving it for later just in case something breaks
  # before_action :set_service, only: [:profile]
  # def set_service
  #   @service = Service.find(params[:id])
  # end

  def about
  end
end
