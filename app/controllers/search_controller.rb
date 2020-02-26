class SearchController < ApplicationController
  def search
      @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
      @book = Book.new
      @users = User.all
    #Viewのformで取得したパラメータをモデルに渡す
    if params[:scope] == "User"
      @users = User.search(params[:search],params[:condition])
      #binding.pry
    elsif params[:scope] == "Book"
      @books = Book.search(params[:search],params[:condition])
    end
  end

end
