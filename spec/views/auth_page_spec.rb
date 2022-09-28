require 'rails_helper'

RSpec.describe 'Authentication test', :js, type: :feature do
  describe 'authentication' do
    scenario 'success sign up and log in' do
      visit new_user_registration_path
      expect(page).to have_content 'Sign up'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
      expect(page).to have_current_path(root_path)

      click_button 'Log Out'

      expect(page).to have_content 'Log in'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end
