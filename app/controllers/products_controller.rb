class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_admin, :only => [:edit, :destroy]
  
  before_action :set_product, only: [:show, :edit, :update, :destroy] 

 
  def index
    @products = Product.all
    if params[:search]
      @products = Product.search(params[:search]).order("created_at DESC")
    else
      @products = Product.all.order('created_at DESC')
    end
  end




 
 
 
 
 
 
 
 
 
 
 
 
 
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  
  end

  # GET /products/1/edit
  def edit
  end

 
  def create
    @product = Product.new(product_params)

      if @product.save
      redirect_to @product, :flash => {success: 'Product was successfully created.'} 
        
      else
        render 'new' 
        
      end
    end
  

  def update
    
      if @product.update(product_params)
     redirect_to @product, :flash => {success: 'Product was successfully updated.' }
       
      else
        render 'edit'
        
      end
    end
  

 
  def destroy
    @product.destroy
    redirect_to products_url, :flash => {danger: 'Product was successfully deleted.' }
      
    end
  
  def ensure_admin
       unless current_user && current_user.admin?
         render :text => "Access Error Message", :status => :unauthorized
       end
     end

  
    # Using callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
  private
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :category, :subcategory)
    end
end
