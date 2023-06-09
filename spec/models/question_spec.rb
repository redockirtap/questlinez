# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'Database table' do
    it { is_expected.to have_db_index(:user_id) }
  end

  context 'Model association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
  end

  context 'Model validation' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
  end
end
