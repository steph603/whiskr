class PagesController < ApplicationController
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

  def find
    @nurses = []
    @users = User.all
    @users.each { | user | 
      if user.is_nurse 
        @nurses << user 
      end 
    }
  end
  
  def about
  end
end
