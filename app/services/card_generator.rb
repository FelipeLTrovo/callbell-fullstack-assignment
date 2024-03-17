class CardGenerator
  def self.generate_card(card_payload)
    return Card.find_by(trello_id: card_payload['id']) if Card.find_by(trello_id: card_payload['id']).present?

    list_payload = {id: card_payload['list_id']}.with_indifferent_access
    Card.new(
              name: card_payload['name'],
              description: card_payload['desc'],
              trello_id: card_payload['id'],
              list: List.where(id: list_payload['id']).or(List.where(trello_id: list_payload['id'])).first
            )
  end
end