class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  #Don't need an index page for addresses, so if a user attempts to view it, reroute to root. 
  #Would like to create an admin login who could have access to the index and edit/delete if needed
  def index
    redirect_to root_path
  end

  # Same as above - do not need to show the address on it's own page.  User can see and edit their own address 
  # via profile/my_profile.  
  def show
    redirect_to root_path
  end

  # GET /addresses/new
  def new
    @address = Address.new
    
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json

  #Auto-sets the new address' user_id to the current user - prevents user having to enter their own id 

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    respond_to do |format|
      if @address.save
        format.html { redirect_to new_pet_path, notice: 'Address was successfully created.' }
        format.json { render :create, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json

  # I dont think this method is utilised anywhere - but keeping it in as I will add admin role later on

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params 
      params.require(:address).permit(:user_id, :street, :suburb, :state, :latitude, :longitude)
    end
end
