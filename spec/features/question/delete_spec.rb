# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated User can delete own questions', "
  In order to manage my questions
  As an authenticated user
  I'd like to be able to delete my questions
" do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user:) }
  given(:another_question) { create(:question, user: another_user) }

  describe 'Authenticated user' do
    background { sign_in user }

    scenario 'can delete the question' do
      visit question_path(question)
      click_on 'Delete'

      expect(page).to have_content 'Question is deleted.'
    end

    scenario "can not delete another's question" do
      visit question_path(another_question)

      expect(page).to_not have_content 'Delete'
    end
  end

  describe 'Unathenticated user' do
    scenario 'can not delete questions' do
      visit question_path(question)

      expect(page).to_not have_content 'Delete'
    end
  end
end
