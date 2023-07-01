class User < ApplicationRecord

  def follow(user)
    record = Follow.new(following_id: user.id, follower_id: id)
    record.save
  end

  def unfollow(user)
    record = Follow.find_by(following_id: user.id, follower_id: id)
    record.destroy if record.present?
  end

  def following?(user)
    Follow.find_by(following_id: user.id, follower_id: id).present?
  end
end
