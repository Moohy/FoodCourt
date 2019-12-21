class ApplicationController < ActionController::Base
    # helper_method :current_user
    before_action :authenticate_user!
    def index
        @user = current_user

    end

    # def current_user
    #     if current_admin.class.name == 'Admin'
    #       current_admin
    #     elsif current_vendor.class.name == 'Vendor'
    #         current_vendor
    #     else
    #       current_customer
    #     end
    #   end

      def after_sign_in_path_for(resource)
          root_path
      end
    
end
