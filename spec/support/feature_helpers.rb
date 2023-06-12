# frozen_string_literal: true

module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    within 'form#new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end
  end

  def post_answer(answer)
    visit question_path(answer.question)
    fill_in 'Body', with: 'Answering text text text'
    click_on 'Create Answer'
  end
end
