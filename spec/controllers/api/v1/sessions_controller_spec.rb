require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) do
      {
        session: {
          coach_hash_id: '3B6V97csyi1x',
          client_hash_id: '3B6V97csyi1x',
          start: DateTime.now,
          duration: 60
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new session' do
        expect do
          post :create, params: valid_params, format: :json
        end.to change(Session, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['status']).to eq('Session created successfully')
      end
    end

    context 'with overlapping sessions' do
      before { create(:session, coach_hash_id: '3B6V97csyi1x', start: DateTime.now, duration: 60) }

      it 'does not create a new session and returns unprocessable entity status' do
        expect do
          post :create, params: valid_params, format: :json
        end.not_to change(Session, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include('Overlapping sessions are not allowed')
      end
    end
  end
end
