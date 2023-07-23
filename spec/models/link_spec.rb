require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'Model association' do
    it { is_expected.to belong_to(:linkable) }
  end

  context 'Model validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :url }
  end
end
