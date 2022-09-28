require 'rails_helper'

RSpec.describe 'User', :js, type: :feature do
  let(:user) { create :user }

    scenario 'success log in' do
      visit root_path
      expect(page).to have_current_path(root_path)
    end
end