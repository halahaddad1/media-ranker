class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  enum selectable_vote_types: [ :upvote, :downvote ]
end
