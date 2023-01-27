class SessionsController < ApplicationController


  skip_before_action :forbid_ifnot_signed_in, only: [:new, :create]
  before_action :forbid_if_signed_in, only: [:new, :create]

  
  def new
    puts "okll"
  end
  def create
    puts "okkkkkkkkkkkkkkkkkk"
    user_params = params.require(:user)
    @user = User.where(username: user_params[:username]).or(User.where(email: user_params[:username])).first
    puts user_params[:username]
    puts "okkkkkkkkkkkkkkkkkk"
    puts User.where(username: user_params[:username]).inspect
    puts "okkkkkkkkkkkkkkkkkk"
    puts User.where(email: user_params[:username]).inspect
    puts "okkkkkkkkkkkkkkkkkk"
    puts @user.inspect
    puts @user.authenticate(user_params[:password])
    puts "------------\n\n\n\n\n"
    if @user and @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to profil_path, success: "Connexion réussi"
    else
      redirect_to sessions_path, danger: 'Identifiants incorrects'
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: "Vous êtes déconnecté"
  end
end
