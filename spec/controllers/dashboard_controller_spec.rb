require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET index' do
    it 'renders the index page' do
      get :index

      expect(response).to render_template :index
      # expect(assigns(:excess_capacities)).to eq([excess_capacity_1, excess_capacity_2])
      # expect(assigns(:excess_capacities).count).to eq(2)
      # expect(assigns(:excess_capacities).first).to be_a ExcessCapacityPresenter
      expect(response.status).to eq(200)
    end
  end
end
