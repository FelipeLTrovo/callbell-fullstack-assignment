class Api::V1::ListsController < ApplicationController

  def index
    @lists = List.all
    render :json => @lists
  end

  def create
    @list = ListGenerator.generate_list(list_params)

    if @list.save
      @client = TrelloWrapper.new
      res = @client.create_list(name: list_params['name'])
      @list.update(trello_id: res.id)
      render :json => @list, status: 200
    end
  end

  def update
    list = ListUpdater.new(list_params).update_list
    if list.valid?
      client = TrelloWrapper.new
      client.update_list(list.attributes)
      render :json => list, status: 200
    end

  end

  private

  def list_params
    params.require(:list).permit(:id, :name, :trello_id) if params.has_key?(:list)
  end
end
