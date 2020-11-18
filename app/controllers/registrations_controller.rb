class RegistrationsController < Devise::RegistrationsController
    protected
  
    #Redirects user to complete their address once initial sign up page completed
    
    def after_sign_up_path_for(resource)
      new_address_path
    end

end