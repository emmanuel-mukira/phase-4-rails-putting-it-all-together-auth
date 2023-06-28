class RecipesController < ApplicationController
    before_action :authorize
  
    def index
      recipes = Recipe.all
      render json: recipes, include: :user, status: :ok
    end
  
    def create
        if session[:user_id]
          recipe = Recipe.new(recipe_params)
          recipe.user_id = session[:user_id]
      
          if recipe.save
            render json: recipe ,include: :user, status: :created
          else
            render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error:  recipe.errors.full_messages  }, status: :unauthorized
        end
      end
      
  
    private
  
    def authorize
      return render json: { error: ["Not logged in"] }, status: :unauthorized unless session.include?(:user_id)
    end
  
    def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete)
    end
  end
  