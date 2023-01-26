class FileValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
        if value
            if value.respond_to? :path
                # puts File.extname(value.path).delete('.')
                # puts options[:ext].join(',')
                # puts options[:ext].include? File.extname(value.path).delete('.')
                # puts options[:ext].include? File.extname(value.path).delete('.').to_sym
                unless options[:ext].include? File.extname(value.path).delete('.').to_sym
                    record.errors.add(attribute, "Fichier non valide (extensions valides: #{options[:ext].join(',')})")
                end
            else
                record.errors(attribute, options[:message] || "entrée non valide!")
            end
        end
        puts record.errors.inspect
    end

end