require File.join(File.dirname(__FILE__), "errors")
require File.join(File.dirname(__FILE__), "yaml_loader")
require File.join(File.dirname(__FILE__), "resolved_context")

module ContextClasses
  class ContextValidator
    def self.compile_contexts_from(klass)
      klass.compile
    end

    def self.load_configuration_from(klass)
      YamlLoader.load_config_file(klass.config_file)
    end

    def self.build_and_validate_using(klass)
      compiled_contexts = compile_contexts_from(klass)
      loaded_configuration = load_configuration_from(klass)
      validate_configuration(compiled_contexts, loaded_configuration)
    end

    def self.validate_configuration(compiled_contexts, loaded_configuration)
      validate_mappings_present(compiled_contexts, loaded_configuration)
      validate_provided_constants(loaded_configuration)
      execute_resolution(compiled_contexts, loaded_configuration)
    end

    def self.validate_mappings_present(compiled_contexts, loaded_configuration)
      missing_keys = compiled_contexts.keys - loaded_configuration.keys
      raise Errors::MissingMappingsError, missing_keys if missing_keys.any?
    end

    def self.validate_provided_constants(loaded_configuration)
      invalid_values = Hash.new
      loaded_configuration.each_pair do |k, v|
        unless check_constant(v)
          invalid_values[k] = v
        end
      end
      raise Errors::InvalidConstantsSpecifiedError, invalid_values if invalid_values.any?
    end

    def self.execute_resolution(compiled_contexts, loaded_configuration)
      ResolvedContext.new(loaded_configuration)
    end

    def self.check_constant(v)
      Object.const_get(v) rescue false
    end
  end
end