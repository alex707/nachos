require 'rails_helper'

feature 'User can see top-3 contributers of repo', %q{
  In order to see top-3 contributers
  I'd like to be able to enter repo path and see top-3 contributers
} do
  describe 'see top-3 contribs' do
    scenario 'search needed repo of some repo' do
      visit top_screen_search_path
      fill_in 'Search repo', with: 'https://github.com/rails/sprockets/'
      click_on 'Search'

      within '.results' do
        expect(page).to have_content('josh')
        expect(page).to have_content('schneems')
        expect(page).to have_content('sstephenson')
      end
    end
  end
end
