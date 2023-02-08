class CommentController < ApplicationController
    before_action :authorize_request
    def create
        comment = Comment.new(user_id: @current_user.id, article_id: params[:article_id], comment_text: params[:text])
        comment.save()
        render json: comment
    end

    def delete
        comment = Comment.find_by(id: params[:id] )
        comment.destroy()
        render json: {message: "successfully deleted message"}, status: :ok 
    end
end
