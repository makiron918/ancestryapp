class ItemsController < ApplicationController
  def index
    @item = Item.all
  end

  def new
    @item = Item.new
    @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
    @category = Category.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
  end

  private
  def product_params
    params.require(:item).permit(:name, category_attributes: [:name])
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
end
