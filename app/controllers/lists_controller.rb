class ListsController < ApplicationController
  before_action :set_board
  before_action :set_list, only: [:show, :edit, :update, :destroy]
 
  def index
    @lists = @board.all_lists(current_user.id)
  end

  def show
  end

  def new
    @list = current_user.lists.new
  end 

  def create
    # INSERT one record
    List.create_list(list_params, current_user.id)
    redirect_to lists_path
  end

  def edit
  end

  def update
    List.update_board(@list.id, list_params)
    redirect_to lists_path
  end

  def destroy
    List.delete_list(@board.id, list.id)
    redirect_to lists_path
  end

  private

    def set_board
      @board = Board.single_list(params[:board_id])
    end
    def set_list
      #SELECT single record
      @list = List.single_list(params[:id])
    end

    def list_params
      params.require(:list).permit(:name)
    end
end
