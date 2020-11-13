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
  
  def about
  end
end
