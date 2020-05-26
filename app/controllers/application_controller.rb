class ApplicationController < ActionController::Base
    
    before_action :set_current_user

    private
    def set_current_user
        @user = User.find_by(id: session[:user_id])
    end
end
