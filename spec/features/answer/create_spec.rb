require 'rails_helper'

feature 'User can create an answer', %q{
  In order to help the community
  As an authenticated user
  I'd like to be able to answer the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
  
      visit question_path(question)
      click_on 'Answer the question'
    end
  
    scenario 'answer the question' do
      fill_in 'Body', with: 'Answering text text text'
      click_on 'Create Answer'
  
      expect(page).to have_content 'Your answer is created.'
      expect(page).to have_content 'Answering text text text'
    end
  
    scenario 'answer the question with empty body' do
      click_on 'Create Answer'
  
      expect(page).to have_content "Body can't be blank"
    end
  end

  
  describe 'Unathenticated user' do
    scenario 'tries to answer the question' do
      visit question_path(question)
      click_on 'Answer the question'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end