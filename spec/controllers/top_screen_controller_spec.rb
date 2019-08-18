require 'rails_helper'

RSpec.describe TopScreenController, type: :controller do
  describe 'GET #search' do
    context 'empty form' do
      before { get :search }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'render search template' do
        expect(response).to render_template(:search)
      end
    end

    context 'form with correct link' do
      let(:link) { 'https://github.com/rails/sprockets/' }
      before { post :search, params: { link: link } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'render search template' do
        expect(response).to render_template(:search)
      end

      it 'populates an array of contributers names' do
        expect(assigns(:contributers)).to eq %w[josh schneems sstephenson]
      end
    end

    context 'form with bad link'
  end
end
