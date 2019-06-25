require File.join(File.dirname(__FILE__), "dsl")

module ContextClasses
  module Config
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def config_file=(path)
        @config_file = path
      end

      def config_file
        @config_file
      end

      def context(name, &block)
        contexts << ::ContextClasses::Dsl::Context.new(name, &block)
      end

      def contexts
        @contexts ||= []
      end

      def compile
        contexts.map(&:compile).reduce(Hash.new) do |acc, hash|
          acc.merge(hash)
        end
      end
    end
  end
end
