class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
    redirect_to tweet_path(@tweet)
  end
  
  def edit 
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to tweet_path(@tweet)
    else
      render :new
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
