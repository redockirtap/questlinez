# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated User can edit own answers', "
  In order to give a correct answer
  As an author of the answer
  I'd like to be able to edit my answer
" do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user:) }
  given(:answer) { create(:answer, question:, user:) }
  given(:another_answer) { create(:answer, question:, user: another_user) }

  describe 'Authenticated user', js: true do
    background { sign_in user }
    background { post_answer(answer) }

    scenario 'can edit the answer' do
      within "#answer_#{answer.id}" do
        click_on 'Edit'
        fill_in 'Body', with: 'Answer is edited.'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Answer is edited.'
        expect(page).to_not have_selector 'textarea'
      end

      expect(page).to have_content 'Answer is edited.'
    end

    scenario "can not edit another's answer" do
      within "#answer_#{another_answer.id}" do
        expect(page).to_not have_content 'Edit'
      end
    end
  end

  describe 'Unathenticated user' do
    scenario 'can not edit answers' do
      visit question_path(question)

      expect(page).to_not have_content 'Edit'
    end
  end
end
