class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :picture, :is_nurse])
    end

    #Redirects user to landing page after signing in - regardless of where their last page - don't 
    #need this anymore but saving for later
    # def after_sign_in_path_for(resource)
    #     root_path
    # end 
    
    
    # Forces users to create a new pet page after creating a new address
    def after_new_address_path
        new_pet_path
    end

end
