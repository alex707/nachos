require 'rails_helper'

RSpec.describe ArchiveMakerService do
  context 'make zip with pdfs', skip: true do
    let(:contributers) { %w[josh_70 schneems_90 sstephenson_80] }
    subject { ArchiveMakerService.new(contributers) }

    after do
      contributers.map { |nickname|
        nickname + '.pdf'
      }.append('diplomas.zip').each do |file|
        if File.exist?("#{Rails.root}/tmp/#{file}")
          File.delete("#{Rails.root}/tmp/#{file}")
        end
      end
    end

    it 'create zip by nicknames' do
      subject.archive

      expect("#{Rails.root}/tmp/diplomas.zip").to be_an_existing_file
    end

    it 'zip-archive include all neddeed pdfs'

    it 'clear zip' do
      subject.archive
      subject.clear

      expect("#{Rails.root}/tmp/diplomas.zip").to_not be_an_existing_file

      subject.contributers.each do |contributer|
        expect("#{Rails.root}/tmp/#{contributer}.pdf").to_not \
          be_an_existing_file
      end
    end

  end
end
