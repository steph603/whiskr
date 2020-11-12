class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :picture, :is_nurse])
    end

    def after_sign_in_path_for(resource)
        root_path
    end 

    def after_new_address_path
        new_pet_path
    end

end
