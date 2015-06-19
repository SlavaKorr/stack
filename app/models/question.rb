class Question < ActiveRecord::Base
	
	has_many :answers, dependent: :destroy

	validates :title,  length: { in: 5..140 }
	validates :body,   length: { in: 10..1000 }

end
