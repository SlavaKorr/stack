require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should accept_nested_attributes_for :attachments }
  it { should have_many :attachments }
  it { should have_many :answers }
  it { should belong_to :user }
  it { should validate_length_of(:title).is_at_least(5).is_at_most(140) }
  it { should validate_length_of(:body).is_at_least(10).is_at_most(1000) }
  it { should validate_presence_of (:user_id)}
end