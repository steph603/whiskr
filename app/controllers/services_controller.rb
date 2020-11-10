class ServicesController < ApplicationController
  load_and_authorize_resource
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :my_services]
  # GET /services
  # GET /services.json

  def index 
    @services = Service.all
  end


  def my_services
    @allservices = Service.all
    @services = []
    
    @allservices.each { |service| 
      if service.user_id == current_user.id
        @services << service
      end
      }
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @booking = Booking.new

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
          name: @service.name,
          description: @service.description,
          # images: [@listing.picture],
          amount: (@service.price * 100).to_i,
          currency: 'aud',
          quantity: 1,
      }],
      payment_intent_data: {
          metadata: {
              listing_id: @service.id
          }
      },
      success_url: "#{root_url}bookings/success?serviceId=#{@service.id}",
      cancel_url: "#{root_url}"
    )
    @session_id = session.id

  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    @service.user_id = current_user.id

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_params
      params.require(:service).permit(:name, :description, :price, :user_id)
    end
end
