class User < ApplicationRecord


    attr_accessor :avatar_file
    
    has_secure_password
    has_secure_token :confirmation_token
    has_secure_token :recover_password
    
    validates :username, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9_-]{2,20}\Z/, message: "Entre 2 et 20 caractère, alpha numérique, plus '-' et '_'"}
    validates :email, presence:true, uniqueness: {case_sensitive: false}
    validates :avatar_file, file: {ext: [:jpg, :jpeg, :png]}
    validates :firstname, presence: true
    
    before_save :avatar_before_upload
    after_save :avatar_after_upload
    after_destroy_commit :avatar_destroy




    def to_session
        {id: id}
    end
    

    def avatar_path
        File.join(
            Rails.public_path, 
        )
    end

    def avatar_url
        "/" + [
            self.class.name.downcase.pluralize,
            id.to_s,
            'avatar.jpg'
        ].join('/')
    end


    private
    
    def avatar_before_upload
        if avatar_file.respond_to? :path
            self.avatar = true
        end
    end
    def avatar_after_upload
        path = avatar_path
        if avatar_file.respond_to? :path
            dir = File.dirname(path)
            FileUtils.mkdir_p(dir) unless Dir.exist?(dir)

            # puts avatar_file.path
            # puts "yooooooooooooooo"
            # FileUtils.cp(avatar_file.path, path)
            image = MiniMagick::Image.new(avatar_file.path) do |b|
                b.resize "150x150^"
                b.gravity "Center"
                b.crop "150x150+0+0" # cropper de 150 par 150, et par rapport au centre de gravité(b.gravity) je ne bouge pas(+0+0)
            end
            image.format 'jpg'
            image.write path
        end
    end

    def avatar_destroy
        dir = File.dirname(avatar_file)
        FileUtils.rm_r(dir) if Dir.exist?(dir)
    end
    


end
