class UserMailer < ApplicationMailer
    default from: "from@example.com"
    layout "mailer"

    def confirm(user)
        @user = user
        mail(
            to: user.email, 
            # subject: "Votre inscription sur le site '"+Rails.application.config.site[:sitename]+"'"
            subject: "Votre inscription sur le site 'exemple.com'"
        )
    end

    def password(user)
        @user = user
        mail(
            to: user.email, 
            # subject: "Réinitialisation de votre mot de passe '"+Rails.application.config.site[:sitename]+"'"
            subject: "Réinitialisation de votre mot de passe 'exemple.com'"
        )
    end
end