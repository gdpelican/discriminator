module Discriminator
  module Methods
    def discriminate(module_name, on:, default: :base)
      define_singleton_method :discriminate_class_for_record, ->(attrs) {
        begin
          "#{module_name.to_s.camelize}::#{attrs.fetch(on.to_s, default).to_s.camelize}".constantize
        rescue NameError
          super(attrs)
        end
      }
    end
  end
end
