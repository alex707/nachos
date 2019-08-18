require 'rails_helper'

RSpec.describe ExportsController, type: :controller do
  describe 'POST #download' do
    context 'export pdf-diploma' do
      let(:contributer) { 'sstephenson_123' }

      it 'download diploma' do
        post :download, params: { contributer: contributer }

        expect(response.headers['Content-Type']).to eq 'application/pdf'
        expect(response.headers['Content-Disposition']).to eq \
          "attachment; filename=\"#{contributer}.pdf\""
      end
    end
  end
end
