module Admin

    class ApplicationController < ::ApplicationController

        before_filter :forbid_ifnot_signed_in_or_admin
        
        # layout 'admin'
        
        private


        def forbid_ifnot_signed_in_or_admin
            if !user_signed_in? || current_user.role != "admin"
                redirect_to new_user_path, danger: "Accès non-autorisé!"
            end
        end
    end

end