require "spec_helper"

RSpec.describe ContextClasses::ContextValidator do
  describe "given missing configuration mappings" do

    let(:config_specification) do
      {"expected_key" => nil}
    end

    let(:config_file_mappings) do
      {"some_other_key" => nil}
    end

    it "errors" do
      expect do
        ContextClasses::ContextValidator.validate_mappings_present(
          config_specification,
          config_file_mappings
        )
      end.to raise_error(ContextClasses::Errors::MissingMappingsError)
    end
  end

  describe "given invalid constants" do
    let(:config_file_mappings) do
      {"some_other_key" => "BLARGLEIsNotAValidCOnstnat"}
    end

    it "errors" do
      expect do
        ContextClasses::ContextValidator.validate_provided_constants(
          config_file_mappings
        )
      end.to raise_error(ContextClasses::Errors::InvalidConstantsSpecifiedError)
    end
  end
end