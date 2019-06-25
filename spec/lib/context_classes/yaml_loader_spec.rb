require "spec_helper"

RSpec.describe ContextClasses::YamlLoader do

  describe "given an invalid file path" do
    it "errors" do
      expect do
        ContextClasses::YamlLoader.load_config_file(nil)
      end.to raise_error(ContextClasses::Errors::InvalidConfigFilePathError)
    end
  end

  describe "given a complex yaml" do
    let(:config_data) do
      <<-YAMLCODE
  context_1:
    sub_context_1:
      key_1: String
  
  context_2:
    key_2: String
  
  context_3:
    key_3: Integer
    subcontext_2:
      sub_sub_context_1:
        key_4: String
      key_5: Integer
      YAMLCODE
    end

    subject { ContextClasses::YamlLoader.parse_config_file(config_data) }

    it "resolves a simple key and context" do
      expect(subject).to have_key("context_2.key_2")
    end

    it "resolves a key a sub context" do
      expect(subject).to have_key("context_1.sub_context_1.key_1")
    end

    it "resolves complex contexts and keys" do
      expect(subject).to have_key("context_3.key_3")
      expect(subject).to have_key("context_3.subcontext_2.key_5")
      expect(subject).to have_key("context_3.subcontext_2.sub_sub_context_1.key_4")
    end
  end
end