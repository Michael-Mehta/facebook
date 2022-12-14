class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def show
        
    end

    def friend
        current_user.send_follow_request_to(@user)
        redirect_to root_path
    end

    def unfriend
        current_user.unfollow(@user)
        @user.unfollow(current_user)
        redirect_to root_path
    end

    def accept
        current_user.accept_follow_request_of(@user)
        current_user.send_follow_request_to(@user)
        @user.accept_follow_request_of(current_user)
        redirect_to root_path
    end

    def decline
        current_user.decline_follow_request_of(@user)
        redirect_to root_path
    end

    def cancel
        current_user.remove_follow_request_for(@user)
        redirect_to root_path
    end

    private

    def set_user
        @user = User.find(params[:id])

    end


end
