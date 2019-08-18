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

    context 'export zip with diplomas' do
      let(:contributers) { %w[josh_2 schneems_32 sstephenson_432] }
      before { post :download, params: { contributers: contributers } }

      it 'download zip with diplomas' do
        expect(response.headers['Content-Type']).to eq 'application/zip'
        expect(response.headers['Content-Disposition']).to eq \
          "attachment; filename=\"diplomas.zip\""
      end
    end
  end
end
