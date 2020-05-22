class User < ApplicationRecord
    has_many :votes
    has_many :liked_works, through: :votes


    

end
