require 'rails_helper'

feature 'Any User can see answers', %q{
  In order to get acquianted with the site
  As any user
  I'd like to be able to see answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question:) }

  describe 'Authenticated user' do

    background do
      sign_in(user)
    end
  
    scenario 'opens all answers' do
      visit question_path(question)
  
      answers.each { |answer| expect(page).to have_content answer.body } 
    end
  end

  
  describe 'Unathenticated user' do
    scenario 'opens all answers' do
      visit question_path(question)
  
      answers.each { |answer| expect(page).to have_content answer.body } 
    end
  end
end
