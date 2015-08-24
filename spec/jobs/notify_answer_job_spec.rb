require 'rails_helper'

RSpec.describe NotifyAnswerJob, type: :job do

  let(:author) { create(:user) } 
  let!(:question) { create(:question, user: author) } 
  let(:answer) { create(:answer, question: question) }

  it "should send email to subscribers" do 
    expect(AnswerMailer).to receive(:notify_about_answer).with(answer).and_call_original
    NotifyAnswerJob.perform_now(answer)
  end
end
