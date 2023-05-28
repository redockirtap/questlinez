# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'Database table' do
    it { is_expected.to have_db_index(:question_id) }
  end

  context 'Model association' do
    it { is_expected.to belong_to(:question) }
  end

  context 'Model validation' do
    it { is_expected.to validate_presence_of :body }
  end
end
