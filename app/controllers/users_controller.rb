class UsersController < ApplicationController

    # before_action :before
    skip_before_action :forbid_ifnot_signed_in, only: [:new, :create, :confirm]
    before_action :forbid_if_signed_in, only: [:new, :create, :confirm]

    # attr_accessor :password_digest
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(clean_params)
        @user.recover_password = nil
        if @user.save
            # LA FONCTIONNALITÉ D'EMAIL NE FONCTIONNE PAS
            # UserMailer.confirm(@user).deliver_now

            
            redirect_to login_path, success: "Veuillez confirmer votre compte dans l'email enovoyé"
            # redirect_to action: :new, success: "Veuillez confirmer votre compte dans l'email enovoyé"
            # redirect_to "/new"
        else
            render "new", status: :unprocessable_entity
        end
    end


    
    def edit
        @user = current_user
    end
    def update
        @user = current_user
        user_params = params.require(:user).permit(:avatar_file, :username, :email, :firstname, :lastname)
        # user_params = params.require(:user).permit(:avatar, :username, :email, :firstname, :lastname)

        # puts user_params[:avatar].inspect
        # puts "okokk\n\n\n"
        if @user.update(user_params)
            redirect_to profil_path, success: "Modifications validées.."
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    
    
    
    def confirm
        @user.find(params[:id])
        if @user.confirmation_token == params[:token]
            @user.update_attributes(confirmation: true, configuration_token: nil)
            @user.save(validate:false)
            session[:auth] = @user.to_session
            redirect_to profil_path, succes: "Votre compte a bien été confirmé"
            # redirect_to new_user_path, succes: "Votre compte a bien été confirmé"
        else
            redirect_to new_user_path, danger: "Ce token n'est pas valide"
        end
    end
    
    private

    def clean_params
        params.require(:user).permit(:username,:email,:password,:password_confirmation)
    end
    def before
        @user = User.find(params[:id])
    end
end