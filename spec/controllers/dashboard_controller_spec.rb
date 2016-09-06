require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET index' do
    let(:earthquake_query) {
      Object.new
    }

    it 'renders the index page with filter params passed in' do
      allow(EarthquakeQuery).to receive(:new).and_return(earthquake_query)
      expect(earthquake_query).to receive(:call).and_return(Fixtures.custom_filter_query)

      get :index, params: { filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: 7 } }
      expect(response).to render_template :index
      expect(assigns(:map_markers_hash).count).to eq 4
      expect(response.status).to eq(200)
    end

    it 'uses default filter values if no filter params are passed in' do
      args = DashboardIndexParams.parse({})
      expect(EarthquakeQuery).to receive(:new).with(args).and_return(earthquake_query)
      expect(earthquake_query).to receive(:call).and_return(Fixtures.custom_filter_query)

      get :index, params: {}
      expect(response).to render_template :index
      expect(assigns(:map_markers_hash).count).to eq 4
      expect(response.status).to eq(200)
    end

    it 'sanitizes a non numeric value for min magnitude filter' do
      args = DashboardIndexParams.parse({ filtered_params: { starttime: '2016-09-01', endtime: '2016-09-02', minmagnitude: 'ab' } }.deep_stringify_keys)
      expect(EarthquakeQuery).to receive(:new).with(args).and_return(earthquake_query)
      expect(earthquake_query).to receive(:call).and_return(Fixtures.single_day_query)

      get :index, params: { filtered_params: { starttime: '2016-09-01', endtime: '2016-09-02', minmagnitude: 'ab' } }
      expect(response).to render_template :index
      expect(assigns(:map_markers_hash).count).to eq 17
      expect(assigns(:filtered_params).min_magnitude).to eq 0
      expect(response.status).to eq(200)
    end

    it 'sets the error message if the query returns a bad response' do
      args = DashboardIndexParams.parse({ filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: "7" } }.deep_stringify_keys)
      expect(EarthquakeQuery).to receive(:new).with(args).and_return(earthquake_query)
      expect(earthquake_query).to receive(:call).and_return(Fixtures.bad_response_query)

      default_earthquake_query = Object.new
      expect(EarthquakeQuery).to receive(:new).with(NullDashboardIndexParams.new).and_return(default_earthquake_query)
      expect(default_earthquake_query).to receive(:call).and_return(Fixtures.default_root_result)

      get :index, params: { filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: 7 } }

      expect(flash[:alert]).to eq 'Something went wrong with your search, please try again.'
      expect(response).to render_template :index
      expect(assigns(:map_markers_hash).count).to eq 12
      expect(response.status).to eq(200)
    end

    it 'sets the error message if the query count exceeds 20,000' do
      args = DashboardIndexParams.parse({ filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: "7" } }.deep_stringify_keys)
      expect(EarthquakeQuery).to receive(:new).with(args).and_return(earthquake_query)
      expect(earthquake_query).to receive(:call).and_return(Fixtures.exceeds_query_limit)

      default_earthquake_query = Object.new
      expect(EarthquakeQuery).to receive(:new).with(NullDashboardIndexParams.new).and_return(default_earthquake_query)
      expect(default_earthquake_query).to receive(:call).and_return(Fixtures.default_root_result)

      get :index, params: { filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: 7 } }

      expect(flash[:alert]).to eq 'Search parameters exceed 20,000 results. Please modify your search parameters.'
      expect(response).to render_template :index
      expect(assigns(:map_markers_hash).count).to eq 12
      expect(response.status).to eq(200)
    end
  end
end
