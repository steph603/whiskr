class PagesController < ApplicationController
  before_action :set_user, only: [:profile]

  def set_user
    @user = User.find(params[:id])
  end
  
  def home
  end

  # This method returns nurses within 10km of the suburb searched for in the search binary
  # Finds all addresses within 10km of search params (Near is a geocoder method) and puts the user_id of each match into an array
  # Then finds all users who are nurses and have an ID contained in the matches array then puts those users into the @nurses array to be rendered 
  # in the view

  def find
    @matches = []
    Address.near(params[:search], 10, units: :km).each { |address| 
      @matches << address.user_id
    }
    @nurses = []
    @users = User.includes(:address).all
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
  end


  def about
  end
end
