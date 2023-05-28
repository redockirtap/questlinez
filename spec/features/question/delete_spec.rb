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

  describe 'Authenticated user' do
    scenario 'can delete their question' do
      sign_in(user)
      visit question_path(question)
      click_on 'Delete'

      expect(page).to have_content 'Question is deleted.'
    end

    scenario "can not delete another's question" do
      sign_in(another_user)
      visit question_path(question)

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
