require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should have_many :votes}
  it { should accept_nested_attributes_for :attachments }
  it { should have_many :attachments }
  it { should belong_to :question } 
  it { should belong_to :user }
  it { should validate_presence_of (:user_id)}
  it { should validate_presence_of :question_id } 
  it { should validate_length_of(:body).is_at_least(10).is_at_most(1000) }


  describe "method #best_answer" do
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

end



