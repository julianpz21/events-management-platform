require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'test fields' do
    subject { build(:enrollment) }

    it "validates uniqueness" do
      is_expected.to validate_uniqueness_of(:user_id).scoped_to(:event_id).
        with_message("only a unique register by event")
    end

    it { is_expected.to be_valid }
  end

  describe 'test association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event) }
  end
end
