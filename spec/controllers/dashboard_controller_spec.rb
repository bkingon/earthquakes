require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET index' do
    it 'renders the index page with filter params passed in' do
      VCR.use_cassette 'custom_filter_query' do
        get :index, params: { filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: 7 } }
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
      expect(assigns(:hash).count).to eq 695
      expect(response.status).to eq(200)
    end

    it 'sanitizes a non numeric value for min magnitude filter' do
      VCR.use_cassette 'non_numeric_value_for_magnitude' do
        get :index, params: { filtered_params: { starttime: '2016-09-01', endtime: '2016-09-02', minmagnitude: 'ab' } }
      end

      expect(response).to render_template :index
      expect(assigns(:hash).count).to eq 265
      expect(assigns(:filtered_params)[:minmagnitude]).to eq 0
      expect(response.status).to eq(200)
    end

    it 'sets the error message if the query returns a bad response' do
      allow_any_instance_of(Faraday::Response).to receive(:status).and_return 400
      VCR.use_cassette 'bad_response_query' do
        get :index, params: { filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: 7 } }
      end

      expect(flash[:alert]).to eq 'Something went wrong with your search, please try again.'
      expect(response).to render_template :index
      expect(assigns(:hash).count).to eq 392
      expect(response.status).to eq(200)
    end

    it 'sets the error message if the query count exceeds 20,000' do
      allow_any_instance_of(Faraday::Response).to receive(:status).and_return 400
      allow_any_instance_of(String).to receive_message_chain(:first, :include?).and_return(true)

      VCR.use_cassette 'exceeds_query_limit' do
        get :index, params: { filtered_params: { starttime: '2016-08-01', endtime: '2016-09-03', minmagnitude: 7 } }
      end

      expect(flash[:alert]).to eq 'Search parameters exceed 20,000 results. Please modify your search parameters.'
      expect(response).to render_template :index
      expect(assigns(:hash).count).to eq 392
      expect(response.status).to eq(200)
    end
  end
end
