# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to the answer', "
  In order to provide link to a source
  As a answer author
  I'd like to be able to add links
" do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:url) { 'https://stackoverflow.com'}

  scenario 'User adds a link to the answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'Answering text text text'

    fill_in 'Link name', with: 'stackoverflow'
    fill_in 'Url', with: url

    click_on 'Create Answer'

    within ".answers" do
      expect(page).to have_link 'stackoverflow', href: url
    end
  end
end
