require 'rails_helper'

feature 'User can see top-3 contributers of repo', %q{
  In order to see top-3 contributers
  I'd like to be able to enter repo path and see top-3 contributers
} do
  describe 'see top-3 contribs' do
    scenario 'search needed repo' do
      visit top_screen_search_path
      fill_in 'Search repo', with: 'https://github.com/rails/sprockets/'
      click_on 'Search'

      within '.results' do
        expect(page).to have_content('josh')
        expect(page).to have_content('schneems')
        expect(page).to have_content('sstephenson')

        expect(page).to have_link('josh.pdf')
        expect(page).to have_link('schneems.pdf')
        expect(page).to have_link('sstephenson.pdf')
      end
    end

    scenario 'tries to search repo by bad link' do
      visit top_screen_search_path
      fill_in 'Search repo', with: 'https://github34.com/rails2/sprockets/'
      click_on 'Search'

      within '.alert' do
        message = 'Check the correctness of the entered link'
        expect(page).to have_content(message)
      end

      expect(find('.results').all('*').length).to eq 0
      expect(find('.results').text).to eq ''
    end
  end
end
