require "spec_helper"

RSpec.describe ContextClasses::Dsl::Key do
  describe "given a kind_of constraint and an invalid value" do
    subject do
      ContextClasses::Dsl::Key.new "a name", kind_of: "String"
    end

    let(:resolved_constant) { Integer }

    it "reports errors" do
      expect(subject.verify_provided(resolved_constant)).to have_key(:kind_of)
    end
  end
end
