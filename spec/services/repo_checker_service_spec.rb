require 'rails_helper'

RSpec.describe RepoCheckerService do
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
    expect(subject.send(:contributers)).to eq %w[josh schneems sstephenson]
  end

  it 'recieve list of contributers' do
    expect(subject.call).to eq %w[josh schneems sstephenson]
  end
end
