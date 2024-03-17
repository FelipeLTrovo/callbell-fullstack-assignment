class Api::V1::CardsController < ApplicationController
  def index
    @cards = Card.all
    render :json => @cards, status: 200
  end

  def create
    @card = CardGenerator.generate_card(card_params)
    
    if @card.save
      @client = TrelloWrapper.new
      res = @client.create_card(name: card_params['name'], description: card_params['desc'], list_id: card_params['list_id'])
      @card.update(trello_id: res.id)
      render :json => @card, status: 200
    end
  end

  def update
    card = CardUpdater.new(card_params).update_card
    if card.valid?
      client = TrelloWrapper.new
      client.update_card(card.attributes)
      render :json => card, status: 200
    end
  end

  def destroy
    card = CardDestroyer.new(card_params).destroy_card
    if card.present?
      client = TrelloWrapper.new
      client.destroy_card(card.trello_id)
      render :json => card, status: 200
    end
  end

  private

  def card_params
    params.require(:card).permit(:id, :name, :trello_id, :list_id, :desc) if params.has_key?(:card)
  end
end
