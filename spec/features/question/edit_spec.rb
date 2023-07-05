# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated User can edit own questions', "
  In order to ask a meaningful question
  As an author of the question
  I'd like to be able to edit my question
" do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user:) }
  given!(:another_question) { create(:question, user: another_user) }

  describe 'Authenticated user', js: true do
    background { sign_in user }

    scenario 'can edit the question' do
      visit question_path(question)

      within "#question_#{question.id}" do
        click_on 'Edit'
        fill_in 'Body', with: 'Question is edited.'
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content 'Question is edited.'
        expect(page).to_not have_selector 'textarea'
      end

      expect(page).to have_content 'Question is edited.'
    end

    scenario "can not edit question with errors" do
      visit question_path(question)

      within "#question_#{question.id}" do
        click_on 'Edit'
        fill_in 'Body', with: ''
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content "Body can't be blank"
      end
    end

    scenario "can not edit another's question" do
      visit question_path(another_question)

      within "#question_#{another_question.id}" do
        expect(page).to_not have_content 'Edit'
      end
    end
  end

  describe 'Unathenticated user', js: true do
    scenario 'can not edit questions' do
      visit question_path(question)

      expect(page).to_not have_content 'Edit'
    end
  end
end
