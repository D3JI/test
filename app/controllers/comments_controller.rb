class CommentsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @boards = Board.find_all_by_boarder_id(params[:user_id])
  end

  def new
    @comment = Comment.new
  end

  def create
    user_data = { :user_id => params[:user_id] }
    case params[:switch]
    when 'entry'
      @entry = Entry.find(params[:entry_id])
      @comment = @entry.comments.create(params[:comment].merge(user_data))
      if @comment.save
        redirect_to user_entry_path(:id => @comment.entry, :user_id => @entry.user)
      end
    when 'photo'
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.create(params[:comment].merge(user_data))
      if @comment.save
        redirect_to user_album_photo_path(:id => @photo.id)
      end
    when 'board'
      @board = Board.create(:boarder_id => params[:user_id],
                            :user_id => logged_in_user.id,
                            :content => params[:board][:content])
      if @board
        redirect_to user_comments_path(:user_id => @board.user)
      end
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.entry_id.nil?
      @photo = Photo.find(params[:photo_id])
      @photo_comment = @photo.comments.find(params[:id])
      @photo_comment.destroy

      redirect_to user_album_photo_path(:id => @photo.id)
    end
    if @comment.photo_id.nil?
      @entry = Entry.find(params[:entry_id])
      @entry_comment = @entry.comments.find(params[:id])
      @entry_comment.destroy
      redirect_to user_entry_path(:id => @entry.id)
    end
  end

  def delete_board
    @board = Board.find(params[:id])
    @user = User.find(params[:user_id])
    @board.destroy
    redirect_to user_comments_path(:boarder_id => @board.boarder_id)
  end
end
