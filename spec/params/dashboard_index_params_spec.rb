require "rails_helper"

describe DashboardIndexParams do
  describe "#parse" do
    context "given no filter parameters" do
      it "returns a NullDashboardIndexParams object" do
        parsed_params = DashboardIndexParams.parse({})
        expect(parsed_params).to be_a NullDashboardIndexParams
      end
    end

    context "given a filtered_params key" do
      it "returns a DashboardIndexParams object" do
        parsed_params = DashboardIndexParams.parse({ "filtered_params" => {} })
        expect(parsed_params).to be_a DashboardIndexParams
      end
    end
  end

  describe "#start_time" do
    it "looks up the start time from the params hash" do
      parsed_params = DashboardIndexParams.new({ "filtered_params" => { "starttime" => '2016-01-01' } })
      expect(parsed_params.start_time).to eq '2016-01-01'
    end
  end

  describe "#end_time" do
    it "looks up the end time from the params hash" do
      parsed_params = DashboardIndexParams.new({ "filtered_params" => { "endtime" => '2016-01-01' } })
      expect(parsed_params.end_time).to eq '2016-01-01'
    end
  end
end
