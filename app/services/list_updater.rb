class ListUpdater
  def initialize(payload)
    @payload = payload
    @list = List.find_by(trello_id: @payload['id']) || List.find(@payload['id'])
  end

  def update_list
    @list.update(
                  name: @payload['name']
                )
    @list
  end
end