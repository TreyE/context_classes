require "context_classes/errors"
require "context_classes/context_validator"
require "context_classes/config"

module ContextClasses
  module Base
    def config
      the_config = Thread.current[:_context_classes_registry_context]
      raise Errors::NeverConfiguredError unless the_config
      the_config
    end

    def configure_using(klass)
      resolved_context = ContextValidator.build_and_validate_using(klass) 
      Thread.current[:_context_classes_registry_context] = resolved_context
    end

    def resolve_class(path)
      config.resolve_class(path)
    end

    def resolve_class_name(path)
      config.resolve_class_name(path)
    end

    def deconfigure!
      Thread.current[:_context_classes_registry_context] = nil
    end
  end

  extend Base
end
