module ContextClasses
  module Errors
    class NeverConfiguredError < StandardError; end
    class InvalidConfigFilePathError < StandardError; end
    class MissingMappingsError < StandardError; end
    class InvalidConstantsSpecifiedError < StandardError; end
  end
end
