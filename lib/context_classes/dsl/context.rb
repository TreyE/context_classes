require File.join(File.dirname(__FILE__), "key")

module ContextClasses
  module Dsl
    class Context
      def initialize(name, &blk)
        @name = name
        @contexts = []
        @keys = []
        instance_exec(&blk)
      end

      def context(name, &blk)
        @contexts << Context.new(name, &blk)
      end

      def key(name)
        @keys << Key.new(name)
      end

      def compile
        compiled_results = Hash.new
        child_keys = @contexts.map do |context|
          context.compile.each_pair do |k, v|
            compiled_results[@name.to_s + "." + k.to_s] = v
          end
        end
        keys = @keys.map do |key|
          compiled_results[@name.to_s + "." + key.name.to_s] = key
        end
        compiled_results
      end
    end
  end
end