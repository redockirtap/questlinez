require 'rails_helper'

RSpec.describe Question, type: :model do

  context 'when question title is valid' do
    it { is_expected.to validate_presence_of :title }
  end
  context 'when question body is valid' do
    it { is_expected.to validate_presence_of :body }
  end
end
