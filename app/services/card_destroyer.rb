class CardDestroyer
  attr_accessor :card

  def initialize(payload)
    @payload = payload
    @card = Card.find_by(trello_id: @payload['id']) || Card.find(@payload['id'])
  end

  def destroy_card
    @card.destroy
  end
end