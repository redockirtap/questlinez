# frozen_string_literal: true

require 'rails_helper'

feature 'Author of question can choose best answer', "
  In order to highlight the best answer
  As an author of the question
  I'd like to be able to pick the best answer
" do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user:) }
  given!(:answers) { create_list(:answer, 3, question:, user:) }

  describe 'Author of the question', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'chooses the best answer' do
      within "#answer_#{answers[1].id}" do
        click_on 'Best Answer'
      end

      expect(page).to have_content 'You chose the best answer.'
    end

    scenario 'best answer is the first' do
      within "#answer_#{answers[1].id}" do
        click_on 'Best Answer'
      end

      expect(page).to have_content 'You chose the best answer.'
    end
  end

  describe 'Another user', js: true do
    background do
      sign_in(another_user)
      visit question_path(question)
    end

    scenario 'can not choose the best answer' do
      within "#answer_#{answers[2].id}" do
        expect(page).to_not have_content 'Best Answer'
      end
    end
  end
end
