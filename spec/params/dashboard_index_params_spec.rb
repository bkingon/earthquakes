require 'rails_helper'

describe DashboardIndexParams do
  describe "#parse" do
    context "given no filter parameters" do
      it "returns a NullDashboardIndexParams object" do
        parsed_params = DashboardIndexParams.parse({})
        expect(parsed_params).to be_a NullDashboardIndexParams
      end
    end
  end
end
