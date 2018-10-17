require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  render_views

  context 'Index' do
    let!(:products) { create_list(:product, 100) }
    let(:response_body) { JSON.parse(response.body) }

    context 'first page' do
      before { get :index, format: :json }

      it do
        expect(response.status).to eq 200
        expect(response_body['total_count']).to eq 100
        expect(response_body['products'].count).to eq 10
        expect(response_body['per_page']).to eq 10
        expect(response_body['page']).to eq 1
      end
    end

    context 'second page' do
      before { get :index, format: :json, params: { page: 2, per_page: 50 } }

      it do
        expect(response.status).to eq 200
        expect(response_body['total_count']).to eq 100
        expect(response_body['products'].count).to eq 50
        expect(response_body['per_page']).to eq 50
        expect(response_body['page']).to eq 2
      end
    end
  end
end
