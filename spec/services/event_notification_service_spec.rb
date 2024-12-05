require 'rails_helper'

RSpec.describe EventNotificationService, type: :service do
  described_class.call

  let!(:event) { create(:event) }
  let!(:enrollment) { create(:enrollment, user_id: event.user_id) }

  describe '#call' do
    it 'run job once and update enrollment' do
      allow(EventNotificationJob).to receive(:perform_later)
      described_class.call
      expect(EventNotificationJob).to have_received(:perform_later).once
      enrollment.reload
      expect(enrollment.notified).to eq(true)
    end
  end
end
