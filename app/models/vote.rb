class Vote < ActiveRecord::Base

  belongs_to :votable, polymorphic: true, touch: true
  belongs_to :user
  validates :value, :user_id, presence: true

end
