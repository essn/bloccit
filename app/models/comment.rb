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
    puts "hello #{post.favorites} #{post.favorites.count}"
    puts " testing again"
    post.favorites.each do |fav|
      puts "in favorites loop #{fav.id}"
      if should_receive_update_for?(fav)
        FavoriteMailer.new_comment(fav.user, post, self).deliver
      end
    end

    puts "#{post.favorites.first}"

    # if post.favorites.first.should_receive_update_for?
    #   FavoriteMailer.new_comment(fav.user, post, self).deliver
    # end
  end

  def should_receive_update_for?(favorite)
    puts "should receive update for says #{favorite.user.email_favorites?}"
    user_id != favorite.user_id && favorite.user.email_favorites?
  end
end
