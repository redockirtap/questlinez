# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated User can delete own answers', "
  In order to manage my answers
  As an authenticated user
  I'd like to be able to delete my answers
" do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user:) }
  given(:answer) { create(:answer, question:, user:) }

  background { post_answer(answer) }

  describe 'Authenticated user' do
    scenario 'can delete their answer' do
      sign_in(user)
      visit question_path(question)
      click_on 'Delete Answer'

      expect(page).to have_content 'Answer is deleted.'
    end

    scenario "can not delete another's answer" do
      sign_in(another_user)
      visit question_path(question)

      expect(page).to_not have_content 'Delete Answer'
    end
  end

  describe 'Unathenticated user' do
    scenario 'can not delete answers' do
      visit question_path(question)

      expect(page).to_not have_content 'Delete Answer'
    end
  end
end
