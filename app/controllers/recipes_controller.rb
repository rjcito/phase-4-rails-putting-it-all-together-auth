class RecipesController < ApplicationController
    def index
        render json: Recipe.all
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user 
            recipe = user.recipes.create(recipe_params)
            if recipe.valid?
                render json: recipe, status: :created
            else
                render json: { errors: ["Not authorized"] }, status: :unprocessable_entity
            end

        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
    end
    
      private
    
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
