class CommentsController < ApplicationController
  
  def index 
    @comments = Comment.all  #No need to specify render
  end

  def new 
    if params[:comment_id] == nil #to determine where comments are being added--link (in which case no comment.id in url) or comment
      @link = Link.find(params[:link_id])
       @object_of_comment = Link.find(params[:link_id])
    else
       @object_of_comment = Comment.find(params[:comment_id])
    end
    @comment = Comment.new 
  end

  def create
    if params[:comment_id] == nil
       @object_of_comment = Link.find(params[:link_id])
    else
       @object_of_comment = Comment.find(params[:comment_id])
    end
    @comment = @object_of_comment.comments.new(comment_params)  
    @link = @comment.find_original_link
    if @comment.save
      flash[:notice] = "comment created."
      redirect_to link_path(@link) #to redirect to show link page after new comment is created.
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.find(params[:id]) 
  end

  def edit 
     @link = Link.find(params[:link_id])
    @comment = Comment.find(params[:id])
  end

  def update 
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to root_path
  end

 def destroy 
    @comment = Comment.find(params[:id])
    @comment.destroy
     flash[:notice] = "comment Deleted"
    @link = @comment.find_original_link
    flash[:notice] = "comment deleted."
      redirect_to link_path(@link)
 end

 private

   def comment_params
      params.require(:comment).permit(:comment, :link_id)
    end
end