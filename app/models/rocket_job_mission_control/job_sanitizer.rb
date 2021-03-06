module RocketJobMissionControl
  module JobSanitizer

    # Returns [Hash] the permissible params for the specified job class, after sanitizing.
    # Parameters
    #   properties [Hash]
    #     Parameters to extract the values from.
    #
    #   job_class [RocketJob::Job]
    #     Job class from which the user editable fields and types will be retrieved.
    #
    #   target [ActiveModel::Base]
    #     Model to set the errors on.
    #
    #   nil_blank [Boolean]
    #     true: Nil out blank fields.
    #     false: Do not return blank fields.
    #     Default: true
    def self.sanitize(properties, job_class, target, nil_blank = true)
      permissible_params = {}
      job_class.user_editable_fields.each do |field_name|
        if value = properties[field_name]
          field = job_class.fields[field_name.to_s]
          next unless field && field.type

          case field.type.name
          when 'Hash'
            begin
              value = value.blank? ? nil : JSON.parse(value)
            rescue JSON::ParserError => e
              target.errors.add(:properties, e.message)
            end
          end

          if value.blank? && !value.is_a?(Hash)
            permissible_params[field_name] = nil if nil_blank
          else
            permissible_params[field_name] = value
          end

        end
      end
      permissible_params
    end

  end
end
