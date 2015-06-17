require 'rails_helper'

RSpec.describe Question, type: :model do

	it { should have_many :answers }

	it { should validate_length_of(:title).is_at_least(5).is_at_most(140) }
	it { should validate_length_of(:body).is_at_least(10).is_at_most(1000) }

end