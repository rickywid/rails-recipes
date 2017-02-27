class RecipesController < ApplicationController

	def index
		@recipe = Recipe.all
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		if @recipe.save
			flash[:success] = "Reciped Created"
			redirect_to @recipe
		else
			render 'new'
		end
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "Recipe Updated"
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy
		flash[:success] = "Reciped Deleted"
		redirect_to root_url
	end

	private

		def recipe_params
			params.require(:recipe).permit(:name, :description, :image, ingredients_attributes: [:id, :ingredient, :_destroy], directions_attributes: [:id, :steps, :_destroy])
		end
end
