require 'rails_helper'

feature 'User can sign sign out', %q{
  In order to end the user session
  As an anauthenticated user
  I'd like to be able to sign out
} do

  given(:user) { create(:user) }
  

  background { visit questions_path }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)
    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unauthenticated user tries to sign out' do
    expect(page).to_not have_content 'Log out'
  end
end
