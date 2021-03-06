class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /bookings
  # GET /bookings.json
  def index

    @prices = []
    @bookings = []
    @all_bookings = Booking.includes(:user, :service, :pet).all
    @all_bookings.each { |booking | 
      if booking.user_id == current_user.id && !booking.paid
      @bookings << booking
      @prices << booking.service.price
      end 
    }


    if @prices.sum > 0
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
            name: 'Your Whiskr Booking',
            amount: (@prices.sum * 100).to_i,
            currency: 'aud',
            quantity: 1,
        }],
        payment_intent_data: {
            metadata: {
                listing_id: @session_id
            }
        },
        success_url: "#{root_url}success?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: "#{root_url}"
      )
      @session_id = session.id
    end

  end

  def success 
    @prices = []
    @bookings = []
    @all_bookings = Booking.includes(:user).all
    @all_bookings.each { |booking | 
      if booking.user_id == current_user.id
      @bookings << booking
      @prices << booking.service.price
      booking.update(paid: true)
      end 
    }
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  #Users do not create a new booking through 
  #this form - so if someone is sneaky and tries to
  #go this route, they will be directed to the find page
  #to search for nurses and services in their area instead
  def new
    redirect_to find_path

  end

  # GET /bookings/1/edit
  def edit
    redirect_to bookings_path
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.service_id = (booking_params[:service_id])

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:user_id, :service_id, :pet_id)
    end
end
