class ListGenerator
  def self.generate_list(payload)
    return List.find_by(trello_id: payload['id']) if List.find_by(trello_id: payload['id']).present?

    List.new(
              name: payload['name'],
              trello_id: payload['id']
            )
  end
end