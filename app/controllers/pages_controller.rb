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
  end
  
  def about
  end
end
