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
  given!(:another_answer) { create(:answer, question:, user: another_user) }

  describe 'Authenticated user', js: true do
    background { sign_in user }
    background { post_answer(answer) }

    scenario 'can delete the answer' do
      within "#answer_#{answer.id}" do
        click_on 'Delete Answer'
      end

      expect(page).to have_content 'Your answer is deleted.'
    end

    scenario "can not delete another's answer" do
      visit question_path(question)

      within "#answer_#{another_answer.id}" do
        expect(page).to_not have_content 'Delete Answer'
      end
    end
  end

  describe 'Unathenticated user', js: true do
    scenario 'can not delete answers' do
      visit question_path(question)

      expect(page).to_not have_content 'Delete Answer'
    end
  end
end
