require "spec_helper"

module ContextClassConfigSpecs
  class CheckedContextConfig
    include ContextClasses::Config

    self.config_file = "context_config.yml"

    context(:context_1) do
      key :key_1
    end
  end
end

RSpec.describe ContextClasses do
  describe "never configured" do
    before do
      ContextClasses.deconfigure!
    end

    it "errors" do
      expect { ContextClasses.resolve_class("something") }.to raise_error(ContextClasses::Errors::NeverConfiguredError)
    end
  end

  describe "configured with a simple mapping" do
    let(:example_config) do
      <<-YAMLCODE
context_1:
  key_1: "::ContextClassConfigSpecs::CheckedContextConfig"
      YAMLCODE
    end

    before do
      allow(File).to receive(:exists?).with("context_config.yml").and_return(true)
      allow(File).to receive(:read).with("context_config.yml").and_return(example_config)
      ContextClasses.configure_using(ContextClassConfigSpecs::CheckedContextConfig)
    end

    it "resolves the class" do
      expect(ContextClasses.resolve_class("context_1.key_1")).to eq(ContextClassConfigSpecs::CheckedContextConfig)
    end

    it "resolves the class name" do
      expect(ContextClasses.resolve_class_name("context_1.key_1")).to eq("::ContextClassConfigSpecs::CheckedContextConfig")
    end
  end
end