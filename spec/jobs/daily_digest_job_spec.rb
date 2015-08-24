require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  it "Send daily digest to user" do 
    expect(User).to receive(:send_daily_digest)
    DailyDigestJob.perform_now
  end
end
