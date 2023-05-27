require 'rails_helper'

feature 'User can sign in', %q{
  In order to ask questions
  As an anauthenticated user
  I'd like to be able to sign up
} do

  given(:user) { build(:user) }
  given(:user_with_taken_email) { create(:user) }

  background { visit new_user_registration_path }

  scenario 'User tries to sign up' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end


  scenario 'User tries to sign up with taken email' do

    fill_in 'Email', with: user_with_taken_email.email
    fill_in 'Password', with: user_with_taken_email.password
    fill_in 'Password confirmation', with: user_with_taken_email.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'User tries to sign up with wrong password confirmation' do

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: 'bad password'
    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match"
  end

  scenario 'User tries to sign up with blank password' do

    fill_in 'Email', with: user.email
    click_on 'Sign up'

    expect(page).to have_content "Password can't be blank"
  end
end
