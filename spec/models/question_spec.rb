require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should have_many :votes}
  it { should accept_nested_attributes_for :attachments }
  it { should have_many :attachments }
  it { should have_many :answers }
  it { should belong_to :user }
  it { should validate_length_of(:title).is_at_least(5).is_at_most(140) }
<<<<<<< HEAD
  it { should validate_length_of(:body).is_at_least(10).is_at_most(1001) }
 
=======
  it { should validate_length_of(:body).is_at_least(10).is_at_most(1000) }
  it { should validate_presence_of (:user_id)}


  describe "#vote_vount" do
    let (:question) {create(:question)}
    let!(:vote_up_list) {create_list(:up_vote, 10, votable: question)}
    let!(:vote_down_list) {create_list(:down_vote, 3, votable: question)}
>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd

    it "should show sum of question votes" do
      expect(question.count_votes).to eq 7
    end
  end
end