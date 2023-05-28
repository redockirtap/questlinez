# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Model association' do
    it { is_expected.to have_many(:questions).dependent(:destroy) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
  end

  context 'Model validation' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  context 'Model methods' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:question) { create(:question, user:) }
    let(:answer) { create(:answer, question:, user:) }

    it 'verifies that current user is author of resource' do
      expect(user.author?(question)).to be(true)
      expect(user.author?(answer)).to be(true)
    end

    it 'verifies that another user is not author of resource' do
      expect(another_user.author?(question)).to be(false)
      expect(another_user.author?(answer)).to be(false)
    end
  end
end
