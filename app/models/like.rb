class Like < ApplicationRecord 
    def all_likes(user_id)
        @user_likes = Like.where("user_id = " + "'" + user_id + "'")
        return @user_likes
    end 
end
