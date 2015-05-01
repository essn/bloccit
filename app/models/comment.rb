# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string
#

class Comment < ActiveRecord::Base

  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :body, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails

  default_scope { order('updated_at DESC') }

  private

  def send_favorite_emails
    post.favorites.each do |fav|
      if should_receive_update_for?(fav)
        FavoriteMailer.new_comment(fav.user, post, self).deliver
      end
    end
  end

  def should_receive_update_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites?
  end
end
