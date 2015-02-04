class LinksController < ApplicationController
  
  def index 
    @links = Link.order_by_rating_formula  
  end

  def new 
    @link = Link.new 
  end

  def create
    @link = Link.new(link_params)  
    if @link.save
      flash[:notice] = "link created."
      redirect_to links_path 
    else
      render 'new' 
    end
  end

  def show
    @link = Link.find(params[:id]) 
  end

  def edit 
    @link = Link.find(params[:id])
  end

  def update 
    @link = Link.find(params[:id])
    @link.update(link_params)
    redirect_to root_path
    #see model for description of alternative method of updating upvotes
  end

 def destroy 
    @link = Link.find(params[:id])
    @link.destroy
     flash[:notice] = "link Deleted"
    redirect_to links_path
 end

 private

    def link_params
      params.require(:link).permit(:name, :url, :upvotes)
    end

end