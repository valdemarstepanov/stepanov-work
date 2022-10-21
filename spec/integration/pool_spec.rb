require 'rails_helper'

RSpec.describe 'Create Pool', :js, type: :feature do
  let!(:user) { create :user }
  let!(:grade) { create :grade }
  let!(:speciality) { create :speciality }
  let!(:profile) { create :profile, user_id: user.id, grade_id: grade.id, 
  speciality_id: speciality.id }

  describe "Create new pool", type: :feature do
  
    scenario 'create new manager pool' do
      login(user)
        
      visit root_path

      find_field(id: "pool_type_manager").click
      find_field(name: 'pool[profile_id]').click
      click_button('Create New Pool')

      expect(page).to have_content 'Succes! New pool is created!'

      # find("a[href='#{pool_path}", match: :smart).click
      # page.driver.browser.switch_to.alert.accept

      # expect(page).to have_content 'Error! New pool is not created!'
    end
  end
end
