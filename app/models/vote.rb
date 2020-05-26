class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work, uniqueness: { scope: :user_id }
  validates :user, uniqueness: { scope: :work_id }
end
