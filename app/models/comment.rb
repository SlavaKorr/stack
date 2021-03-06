class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true

  validates :comment_body, length: { in: 10..1000 }

end
