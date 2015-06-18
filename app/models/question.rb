class Question < ActiveRecord::Base
  
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title,  length: { in: 5..140 }
  validates :body,   length: { in: 10..1000 }
  validates :user_id, presence: true

end
