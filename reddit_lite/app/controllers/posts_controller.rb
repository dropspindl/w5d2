class PostsController < ApplicationController

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub_id)
    end
  end

  def show
    @post = Post.find(params[:id])
    @sub = @post.sub
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless current_user == @post.author
  end

  def update

    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless current_user == @post.author
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])

  end

end
