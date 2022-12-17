class PostsController < ApplicationController

    before_action :authenticate_user!
    
    def new
        @post = Post.new
    end

    def create 
        
        @post = current_user.posts.build(post_params)
        @post.user = current_user

        respond_to do |format|
        if @post.save
            
            format.html { redirect_to root_path, notice: 'Post was successfully created.' }
            format.json { render :show, status: :created, location: @post }
            
          else
            
            format.html { render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }
            end
          end
    end

    def index 
        @posts = Post.all.order(created_at: :desc)
    end
    
    def show
        @post = Post.find(params[:id])
        
    end


    def like

        @post = Post.all.find(params[:id])

        Like.create(user_id: current_user.id, post_id: @post.id)
        redirect_to post_path(@post)
    end

    

    private

    def post_params
        params.require(:post).permit(:body)
    end

    
end
