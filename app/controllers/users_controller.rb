class UsersController < ApplicationController
    before_action :authenticate_user!
 
    

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
