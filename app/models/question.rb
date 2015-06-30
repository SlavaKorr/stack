class Question < ActiveRecord::Base
  
  belongs_to :user
  has_many   :attachments, as: :attachable
  has_many   :answers, dependent: :destroy

  accepts_nested_attributes_for :attachments 

  validates :title,  length: { in: 5..140 }
  validates :body,   length: { in: 10..1000 }
  validates :user_id, presence: true

end
