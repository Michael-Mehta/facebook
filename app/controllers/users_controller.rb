class UsersController < ApplicationController
    before_action :authenticate_user!
 
    def create
        
        respond_to do |format|
            if @user.save
              # Tell the UserMailer to send a welcome email after save
              UserMailer.with(user: @user).welcome_email.deliver_later
      
              format.html { redirect_to(@user, notice: 'User was successfully created.') }
              format.json { render json: @user, status: :created, location: @user }
            else
              format.html { render action: 'new' }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def index
        @users = User.all
    end

    def friend
        @user = User.find(params[:id])
        current_user.send_follow_request_to(@user)
        redirect_to root_path
    end

    def unfriend
        @user = User.find(params[:id])
        current_user.unfollow(@user)
        @user.unfollow(current_user)
        redirect_to root_path
    end

    def accept
        @user = User.find(params[:id])
        current_user.accept_follow_request_of(@user)
        current_user.send_follow_request_to(@user)
        @user.accept_follow_request_of(current_user)
        redirect_to root_path
    end

    def decline
        @user = User.find(params[:id])
        current_user.decline_follow_request_of(@user)
        redirect_to root_path
    end

    def cancel
        @user = User.find(params[:id])
        current_user.remove_follow_request_for(@user)
        redirect_to root_path
    end

  

    


end
