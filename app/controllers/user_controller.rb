class UserController < ApplicationController
    
    # skip_before_action :verify_authenticity_token
    before_action :authorize_request, except: [:create, :index, :show, :destroy]

    before_action :find_user, except: %i[create index]
    
    # GET /user
    def index
        @users = User.all
        render json: @users, :except => :password_digest
    end
    
    # GET /users/{username}
    def show
        if params[:id]
            user = User.find_by(id: params[:id])
            render json: { user: user.as_json( except: [:password_digest])}, status: :ok
        end
    end
    
    # POST /users
    def create
        @user = User.new(user_params)
        if @user.save
        render json: @users, :except => :password_digest, status: :created
        else
        render json: { errors: @user.errors.full_messages },
                status: :unprocessable_entity
        end
    end
    
    # PUT /users/{username}
    def update
        
        unless @current_user.update(user_params)
            render json: { errors: @user.errors.full_messages },
                status: :unprocessable_entity
        else
            render json: @current_user, :except => :password_digest, status: :updated
        end
        
    end

    #---------- not-in-functionality ---- keeping-to-reset-database-----
    # DELETE /users/{username}
    def destroy
        for user in User.all
            user.destroy
        end
    end
    
    private
    
    def find_user
        @user = User.find_by(params[:id])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end
    
    def user_params
        params.permit(
            :name, :email, :password, :description, :avatar_url
        )
    end
   
    
end
