require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should have_many :comments}
  it { should have_many :votes}
  it { should accept_nested_attributes_for :attachments }
  it { should have_many :attachments }
  it { should belong_to :question } 
  it { should belong_to :user }
  it { should validate_presence_of (:user_id)}
  it { should validate_presence_of :question_id } 
  it { should validate_length_of(:body).is_at_least(10).is_at_most(1000) }


  describe "#best_answer" do
    let (:question) {create(:question)}
    let!(:best_answer) {create(:best_answer, question: question)}
    let!(:answer) {create(:answer, question: question)}
      
    
    it "should change best answer" do
      expect(answer.best_answer).to eq false
      expect(best_answer.best_answer).to eq true

      answer.best

      answer.reload
      best_answer.reload

      expect(answer.best_answer).to eq true
      expect(best_answer.best_answer).to eq false
    end
  end

  describe '#notify' do
    let(:owner_question) { create(:user) }
    let(:user) { create(:user) }
    let!(:question) {create(:question, user: owner_question) }
    let(:answer) { create(:answer, question: question, user: user)}

    subject { build(:answer, question: question) }


    it 'after creating questions author should receive answer on email' do
      expect(NotifyAnswerJob).to receive(:perform_now).with(subject).and_call_original
      subject.save!
    end
  end

end



