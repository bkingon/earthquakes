require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET index' do
    it 'renders the index page with filter params passed in' do
      VCR.use_cassette 'custom_filter_query' do
        get :index, params: { filtered_params: {starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: 7 } }
      end

      expect(response).to render_template :index
      expect(assigns(:hash).count).to eq 4
      expect(response.status).to eq(200)
    end

    it 'uses default filter values if no filter params are passed in' do
      allow_any_instance_of(Date).to receive(:yesterday).and_return(Date.parse('2016-09-03'))
      allow_any_instance_of(Date).to receive(:today).and_return(Date.parse('2016-09-04'))
      VCR.use_cassette 'default_root_result' do
        get :index, params: {}
      end

      expect(response).to render_template :index
      expect(assigns(:hash).count).to eq 534
      expect(response.status).to eq(200)
    end
  end
end
