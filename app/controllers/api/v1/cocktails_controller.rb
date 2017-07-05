class Api::V1::CocktailsController < ApplicationController
  def index
    render json: Cocktail.all
  end

  def show
    render json: Cocktail.find(params[:id])
  end

  def create
    cocktail = Cocktail.new(name: params[:name], description: params[:description], source: params[:source], instructions:
    params[:instructions])
    if cocktail.save
      params[:proportions].each do |proportion|
        portion = Proportion.new(amount: proportion[:amount], ingredient: Ingredient.find_or_create_by(name: proportion[:ingredient]))
        portion.save
        cocktail.proportions << portion
      end
    else
      render json: {message: cocktail.errors.full_messages, status: 500}
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
