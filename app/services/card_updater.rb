class CardUpdater
  def initialize(payload)
    @payload = payload
    @card = Card.where(id: payload['id']).or(Card.where(trello_id: payload['id'])).first
    list_id = @payload['idList'] || @payload['list_id']
    @list = List.find_by(trello_id: list_id) if list_id.present?
  end

  def update_card
    @card.update(
                  name: @payload['name'] || @card.name,
                  description: @payload['desc'] || @card.description,
                  list: @list.present? ? @list : @card.list
                )
    @card
  end
end