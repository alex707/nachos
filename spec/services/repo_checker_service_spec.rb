require 'rails_helper'

RSpec.describe RepoCheckerService do
  context 'with correct link' do
    let(:link) { 'https://github.com/rails/sprockets/' }
    subject { RepoCheckerService.new(link) }

    it 'makes url to api-url' do
      expect(subject.api_link).to eq \
        "https://api.github.com/repos/rails/sprockets/" \
          "contributors?q=contributions&order=desc"
    end

    it 'get content from github' do
      expect(subject.send(:request_data)).to_not be_empty
    end

    it 'make list of contributers' do
      expect(
        subject.send(:check_contributers)
      ).to eq %w[josh schneems sstephenson]
    end

    it 'recieve list of contributers' do
      subject.call
      expect(subject.contributers).to eq %w[josh schneems sstephenson]
    end

    it 'http status is 200' do
      subject.call
      expect(subject.response_code).to eq '200'
    end
  end

  context 'with bad link' do
    let(:link) { 'https://github34.com/rails2/sprockets/' }
    subject { RepoCheckerService.new(link) }

    it 'http status is 404' do
      subject.call
      expect(subject.response_code).to eq '404'
    end
  end
end
