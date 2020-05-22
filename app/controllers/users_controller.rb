class UsersController < ApplicationController

    def index
        @users= User.all
    end 

    def show
        user_id = params[:id]
        @user = User.find_by(id: user_id)
        if @user.nil?
          head :not_found
        return
        end
    end

    def create
        @user = User.new(user_params) 
        if @user.save 
          flash[:success] = "user created successfully!"
          redirect_to root_path 
          return
        else 
          flash[:error] = "user cannot be added!"
          render :index, status: :bad_request 
          return
        end
    end

    def login_form
        @user = User.find_by(id: session[:user_id])
        if @user.nil?
            @user = User.new
        end 
    end

    def login
        username = params[:user][:username]
        @user = User.find_by(username: username)
    

        if @user
          session[:user_id] = @user.id
          flash[:success] = "Successfully logged in as returning user #{username}"
        else
          @user = User.create(
              username: username,
              joined: Time.now.to_s)
              puts @user.username
            if @user.save
          session[:user_id] = @user.id
          flash[:success] = "Successfully logged in as new user #{username}"
          end
        end

        redirect_to root_path
        return
      end


      def logout
        session[:user_id] = nil
        flash[:success] = "Successfully logged out"
        redirect_to root_path
        return
      end

      def work_params
        return params.require(:user).permit(:username,:joined,:vote_id)
      end
end
