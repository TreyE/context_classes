require 'yaml'
require File.join(File.dirname(__FILE__), "errors")

module ContextClasses
  class YamlLoader
    def self.load_config_file(config_file_path)
      raise(Errors::InvalidConfigFilePathError, config_file_path) unless config_file_path
      raise(Errors::InvalidConfigFilePathError, config_file_path) unless File.exist?(config_file_path)
      parse_config_file(File.read(config_file_path))
    end

    def self.parse_config_file(file_data)
      yaml_data = YAML.safe_load(file_data)
      flatten_yaml(yaml_data)
    end

    def self.flatten_yaml(yaml_data, prefix = "")
      result_keys = Hash.new
      yaml_data.each_pair do |k, v|
        if v.kind_of?(Hash)
          flatten_yaml(v, prefix + k.to_s + ".").each_pair do |fk, fv|
            result_keys[fk.to_s] = fv
          end
        else
          result_keys[prefix + k.to_s] = v
        end
      end
      result_keys
    end
  end
end
