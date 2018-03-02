class ReviewsController < ApplicationController

  before_action :ensure_logged_in

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
    @review = Review.find(params[:id])
    @product = @review.product
  end

  def update
    @review = Review.find(params[:id])

    @review.comment = params[:review][:comment]

    if @review.save
      redirect_to "/products/#{params[:product_id]}"
    else
      flash[:alert] = "Review cannot be empty!"
      redirect_to "/products/#{params[:product_id]}/reviews/#{params[:id]}/edit"
    end
  end

  def destroy
    @review = Review.find(params[:id])

    @review.destroy
    flash[:notice] = "You have successfully deleted the review!"
    redirect_to "/products/#{params[:product_id]}"
  end

end
