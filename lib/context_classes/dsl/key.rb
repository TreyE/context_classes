require File.join(File.dirname(__FILE__), "key")

module ContextClasses
  module Dsl
    class Key
      attr_reader :name

      def initialize(name, options = {})
        @name = name
      end
    end
  end
end