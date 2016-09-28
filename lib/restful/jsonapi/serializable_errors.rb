module Restful
  module Jsonapi
    module SerializableErrors
      extend ActiveSupport::Concern

      def serializable_errors(object, options={})
        #prefix = object.class.to_s.demodulize.underscore

        errors = object.errors.to_hash.each_with_object([]) do |(k, v), array|
          v.each do |msg|
            translated_key = "#{k.to_s.gsub('_', '-')}"
            array.push(
                       title: msg,
                       detail: "#{k.to_s.camelize} #{msg}",
                       source: { pointer: "/data/attributes/#{translated_key}"}
                      )
          end
        end

        { errors: errors }
      end
    end
  end
end
