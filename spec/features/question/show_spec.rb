# frozen_string_literal: true

require 'rails_helper'

feature 'Any User can see questions', "
  In order to get acquianted with the site
  As any user
  I'd like to be able to see questions
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:questions) { create_list(:question, 3) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario 'opens all questions' do
      visit questions_path

      questions.each do |question|
        expect(page).to have_content question.title
        expect(page).to have_content question.body
      end
    end

    scenario 'opens a specific question' do
      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end

  describe 'Unathenticated user' do
    scenario 'opens all questions' do
      visit questions_path

      questions.each do |question|
        expect(page).to have_content question.title
        expect(page).to have_content question.body
      end
    end

    scenario 'opens a specific question' do
      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end
