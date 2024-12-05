require 'rails_helper'

RSpec.describe EventNotificationJob, type: :job do
  include ActiveJob::TestHelper

  let(:event) { create(:event) }
  let(:user) { create(:user) }

  subject(:job) { described_class }

  describe 'test job' do
    it 'queues the job' do
      expect { job.perform_later(event.id, user.id) }.to have_enqueued_job(job).
        with(event.id, user.id).on_queue('default')
    end

    it "sends the correct email" do
      expect { job.perform_now(user, event) }.to change { ActionMailer::Base.deliveries.count }.by(1)

      email = ActionMailer::Base.deliveries.last
      expect(email.to).to include(user.email)
      expect(email.subject).to eq("Please attend Event")
    end
  end
end
