class PasswordsController < ApplicationController


    skip_before_action :forbid_ifnot_signed_in
    before_action :forbid_if_signed_in

    def new
        
    end

    def create
        user_param = params.require(:user)
        @user = User.find_by_email(user_param[:email])
        if @user
            @user.regenerate_recover_password
            # UserMailer.password(@user).deliver_now
            redirect_to new_session_path, success: "Un email vous a été envoyé"
        else
            redirect_to new_password_path, danger: "User incorrecte"
        end
    end
    
    def edit
        @user = User.find(params[:id])
        if @user.recover_password != params[:token]
            redirect_to new_password_path, danger: 'Token invalide'
        end
    end
    def update
        user_param = params.require(:user).permit(:password, :password_confirmation, :recover_password)
        @user = User.find(params[:id])
        if @user.recover_password == user_param[:recover_password]
            @user.assign_attributes(user_params)
            if @user.valid?
                @user.recover_password = nill
                @user.save
                session[:auth] = @user.to_session
                redirect_to profil_path, success: "Mot de passe modifié"
            else
                render :edit
            end
        else
            redirect_to new_password_path, danger: 'Token invalide'
        end
    end


    private
    
    def 
    end

end