# frozen_string_literal: true

class ItemCategoriesController < ApplicationController
  before_action :find_item_category, only: %i[edit update destroy show]

  def index
    @item_categories = ItemCategory.all
  end

  def new
    @item_category = ItemCategory.new
  end

  def create
    @item_category = ItemCategory.new(item_category_params)
    if @item_category.save
      redirect_to item_categories_path
      flash.notice = 'ItemCategory created successfully!'
    else
      redirect_to new_item_category_path
      flash.alert = @item_category.errors.full_messages[0]
    end
  end

  def show; end

  def edit; end

  def update
    if @item_category.update(item_category_params)
      redirect_to item_categories_path
      flash.notice = 'ItemCategory updated successfully!'
    else
      redirect_to edit_item_category_path
      flash.alert = 'ItemCategory failed to update!'
    end
  end

  def destroy
    if @item_category.destroy
      flash.notice = 'ItemCategory deleted successfully!'
    else
      flash.alert = 'ItemCategory failed to delete!'
    end
    redirect_to item_categories_path
  end

  private

  # use callbacks to share common setup or constraints between actions.
  def find_item_category
    @item_category = ItemCategory.find(params[:id])
  end

  def item_category_params
    params.require(:item_category).permit(:name)
  end
end
