require 'rails_helper'

RSpec.describe DiplomaMakerService do
  context 'make single pdf', skip: true do
    let(:contributer) { 'schneems_90' }
    subject { DiplomaMakerService.new(contributer) }

    after do
      if File.exist?("#{Rails.root}/tmp/#{contributer}.pdf")
        File.delete("#{Rails.root}/tmp/#{contributer}.pdf")
      end
    end

    it 'create pdf by nickname' do
      subject.diploma('schneems_90')

      expect("#{Rails.root}/tmp/#{contributer}.pdf").to be_an_existing_file
    end

    it 'clear pdf' do
      subject.diploma('schneems_90')
      subject.clear

      expect("#{Rails.root}/tmp/#{contributer}.pdf").to_not be_an_existing_file
    end
  end
end
