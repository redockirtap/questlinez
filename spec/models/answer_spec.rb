# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'Database table' do
    it { is_expected.to have_db_index(:question_id) }
    it { is_expected.to have_db_index(:user_id) }
  end

  context 'Model association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:question) }
  end

  context 'Model validation' do
    it { is_expected.to validate_presence_of :body }
  end

  context 'Model methods' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:question) { create(:question, user:) }
    let!(:answer) { create(:answer, question:, user:) }

    it 'assigns the best answer for the question' do
      expect(question.answers[0].set_best).to be(true)
    end
  end
end
