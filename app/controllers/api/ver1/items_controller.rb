class Api::Ver1::ItemsController < ApplicationController
  
  def index
    items = Item.order(created_at: :desc)
    render json: { 
      status: 'SUCCESS', 
      message: 'Get items', 
      data: items
    }
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: { 
        status: 'SUCCESS', 
        message: 'Saved item', 
        data: item
      }
    else
      render json: { 
        status: 'ERROR', 
        message: 'Not saved item', 
        data: item.errors
      }
    end
  end

  private def item_params
    params.require(:item).permit(
      :name,
      :price
      )
  end
end
