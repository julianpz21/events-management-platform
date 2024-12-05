require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'test fields' do
    subject { build(:event) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:capacity) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:place) }

    it { is_expected.to be_valid }
  end

  describe 'test association' do
    it { is_expected.to belong_to(:user) }
  end
end
