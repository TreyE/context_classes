module ContextClasses
  class ResolvedContext
    def initialize(verified_configuration)
      @classes = Hash.new
      @class_names = Hash.new
      verified_configuration.each_pair do |k, v|
        kls = Object.const_get(v)
        @classes[k.to_s] = kls
        @class_names[k.to_s] = v
      end
    end

    def resolve_class(key)
      @classes[key.to_s]
    end

    def resolve_class_name(key)
      @class_names[key.to_s]
    end
  end
end
