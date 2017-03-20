class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  before_action :shop_opened , only: [:add_to_cart]
  
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
    @recipe = Recipe.new    
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
   @recipe.cusine = params[:recipe][:cusine]

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        @recipes = Recipe.all
        format.html { render :index }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipes_path, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_cart
    @recipe = Recipe.find(params[:format])
    unless current_user.recipes.map(&:price).inject(0, :+) + @recipe.price > current_user.wallet 
      if current_user.recipes.count < 5 
        if @recipe.availability
          @recipe.cart_recipes.build(user_id: current_user.id)
          @recipe.save
          if request.xhr?
            @count = current_user.cart_recipes.count
            render json: { count: @count , id: current_user.id }
          else
            redirect_to request.referer_path
          end
        else
          redirect_to root_path , notice: 'This Recipe is not available for Now' 
        end
      else
      redirect_to root_path, notice: 'More Than 5 Recipes cannot be added in Cart'
      end 
    else
      redirect_to root_path, notice: 'Add Money In Walley by Recharge'
    end   
  end

  def remove_cart_item
    @cart_recipe = current_user.cart_recipes.where(:recipe_id => params[:format])
    @cart_recipe.first.destroy
    redirect_to cart_path
  end

  def availability
    @recipe = Recipe.find(params[:format])
    @recipe.toggle(:availability)
    @recipe.save
    if request.xhr?
      render json: { id: params[:format] }
    else
      redirect_to request.referer_path
    end
  end

  def import
    Recipe.import(params[:file])

    redirect_to recipes_path, notice: 'Recipes imported.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:sku, :name, :serving, :price, :non_veg)
    end
end
