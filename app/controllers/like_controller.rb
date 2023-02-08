class LikeController < ApplicationController
    before_action :authorize_request
    
    def home
        begin
            # ...
            like = Like.new(user_id: @current_user.id, article_id: params[:article_id])
            like.save()
        
            author_id = Article.find_by(id: params[:article_id]).user_id
            @author = User.find_by(id: author_id)
            @author.likes_count += 1
            @author.save()
            
            render json: {"message": "liked"}, status: :ok
          rescue => e
            # ...
            like = Like.find_by(user_id: @current_user.id, article_id: params[:article_id])
            like.destroy()

            author_id = Article.find_by(id: params[:article_id]).user_id
            @author = User.find_by(id: author_id)
            @author.likes_count -= 1
            @author.save()

            render json: {"message": "unliked"}, status: :ok
          end
       
    end


end
