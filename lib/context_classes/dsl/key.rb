require File.join(File.dirname(__FILE__), "key")

module ContextClasses
  module Dsl
    class Key
      attr_reader :name

      def initialize(name, options = {})
        @name = name
        parse_options(options)
      end

      def verify_provided(constant)
        errs = Hash.new
        if @requires_kind_of
          unless constant.ancestors.include?(@requires_kind_of)
            errs[:kind_of] = @requires_kind_of
          end
        end
        errs
      end

      def parse_options(options)
        opts = Hash.new
        options.each_pair do |k, v|
          opts[k.to_s] = v
        end
        if opts.key?("kind_of")
          @requires_kind_of = Object.const_get(opts["kind_of"])
        end
      end
    end
  end
end
