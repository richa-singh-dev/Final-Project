class CommentController < ApplicationController
    before_action :authorize_request
    def create
        comment = Comment.new(user_id: @current_user.id, article_id: params[:article_id], comment_text: params[:text])
        comment.save()
        render json: comment

        article = Article.find_by(id: params[:article_id])
        article.article_comments_count += 1
        article.save()

        render json: {message: "successfully added comment"}, status: :created
    end

    def delete
        comment = Comment.find_by(id: params[:id] )
        comment.destroy()

        article = Article.find_by(id: params[:article_id])
        article.article_comments_count -= 1
        article.save()

        render json: {message: "successfully deleted comment"}, status: :ok 
    end

   
end
