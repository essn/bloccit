class FavoriteMailer < ApplicationMailer
  default from: "jessepledger@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-Id"] = "<comments/#{comment.id}@your-app-name.example.com"
    headers["In-Reply_To"] = "<post/#{post.id}@your-app-name.example.com"
    headers["References"] = "<post/#{post.id}@your-app-name.example.com"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
