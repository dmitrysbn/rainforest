class ReviewsController < ApplicationController

  before_action :ensure_logged_in
  before_action :load_review, only: [:edit, :update, :destroy]
  before_action :ensure_user_wrote_review, only: [:edit, :update, :destroy]

  def create
    @review = Review.new

    @review.comment = params[:review][:comment]
    @review.product_id = params[:product_id]
    @review.user_id = current_user.id

    if @review.save
      redirect_to "/products/#{params[:product_id]}"
    else
      flash[:alert] = "Review cannot be empty!"
      redirect_to "/products/#{params[:product_id]}"
    end

  end

  def edit
    @product = @review.product
  end

  def update
    @review.comment = params[:review][:comment]

    if @review.save
      redirect_to "/products/#{params[:product_id]}"
    else
      flash[:alert] = "#{@review.errors.full_messages}"
      redirect_to "/products/#{params[:product_id]}/reviews/#{params[:id]}/edit"
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "You have successfully deleted the review!"
    redirect_to "/products/#{params[:product_id]}"
  end

  def load_review
    @review = Review.find(params[:id])
  end

  def ensure_user_wrote_review
    unless current_user == @review.user
      flash[:alert] = "Please log in"
      redirect_to new_sessions_url
    end
  end

end
