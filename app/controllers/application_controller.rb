class ApplicationController < ActionController::Base

    before_action :logs
    before_action :forbid_ifnot_signed_in
    add_flash_types :success, :danger
    helper_method :current_user, :user_signed_in?

    private

    def logs
        puts session
        puts !session
        puts !session || !session[:auth]
        puts !session || !session[:auth] || !session[:auth]['id']
        puts !current_user.nil?
        puts current_user.inspect
        puts "-----------______________\n\n\n\n"
    end

    def forbid_ifnot_signed_in
        if !user_signed_in?
            redirect_to new_user_path, danger: "Accès non-autorisé!"
        end
    end

    def forbid_if_signed_in
        if user_signed_in?
            redirect_to profil_path
        end
    end

    def user_signed_in?
        !current_user.nil?
    end

    def current_user
        return nil if !session || !session[:auth]|| !session[:auth]['id']
        return @_user if @_user
        @_user = User.first
        # @_user = User.find_by_id(session[:auth]['id'])     
    end
end
