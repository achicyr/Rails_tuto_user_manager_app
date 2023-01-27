module PermissionHelper

    def canEdit(recor)
        if record.respond_to?(:user_id) and user_signed_in? and record.user_id === current_user.id
            true
        else
            false
        end
    end

    def isAdmin?
        user_signed_in? && current_user.role == "admin"
    end

end