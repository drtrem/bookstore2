class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_to book_path(params[:comment][:product_id])
  end
 
  private
    def comment_params
      params.require(:comment).permit(:product_id, :user_id, :commenter, :body, :rate)
    end
end
