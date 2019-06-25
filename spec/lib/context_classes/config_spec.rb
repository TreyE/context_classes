require "spec_helper"

module ContextClassConfigSpecs
  class SimpleConfig
    include ContextClasses::Config

    context(:context_1) do
      key :key_1
    end
  end
end

RSpec.describe ContextClasses::Config do
  describe "given a simple context" do
    it "compiles correctly" do
      compiled_items = ContextClassConfigSpecs::SimpleConfig.compile
      expect(compiled_items).to have_key("context_1.key_1")
    end
  end
end
