# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to the question', "
  In order to provide link to a source
  As a question author
  I'd like to be able to add links
" do

given(:user) { create(:user) }
given(:url) { 'https://stackoverflow.com'}

scenario 'User adds a link to the question' do
  sign_in(user)
  visit new_question_path

  fill_in 'Title', with: 'test quest'
  fill_in 'Body', with: 'body'

  fill_in 'Link name', with: 'stackoverflow'
  fill_in 'Url', with: url

  click_on 'Ask'

  expect(page).to have_link 'stackoverflow', href: url
end

end