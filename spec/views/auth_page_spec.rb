require 'rails_helper'

RSpec.describe 'Authentication test', :js, type: :feature do
  describe 'authentication' do
    scenario 'success sign up and sign in' do
      visit new_user_registration_path

      expect(page).to have_content 'Sign up'

      within('form') do
        fill_in 'Email address', with: 'user@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign up'
      end

      expect(page).to have_current_path(root_path)

      click_button 'Log Out'

      expect(page).to have_content 'Sign in to your account'

      within('form') do
        fill_in 'Email address', with: 'user@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Sign in'
      end

      expect(page).to have_current_path(root_path)
    end
  end
end
