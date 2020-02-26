class BookCommentsController < ApplicationController

  def create
    #binding.pry
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
    #redirect_to book_path(book), notice: "successfully created comment!"
    else
      @new_book = Book.new
      @book = Book.find(params[:book_id])
      @user = User.find_by(id: current_user.id)
      render 'books/show'
    end

  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    #binding.pry
    #comment = current_user.book_comments
    @book_comment.destroy
    #redirect_to book_path(book), notice: "successfully deleated comment!"
  end

private
def book_comment_params
    params.require(:book_comment).permit(:comment)
end

end
