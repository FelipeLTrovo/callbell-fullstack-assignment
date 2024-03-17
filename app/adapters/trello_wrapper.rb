require 'trello'

class TrelloWrapper
  attr_accessor :board

  def initialize()
    @client ||= 
    Trello::Client.new(developer_public_key: ENV['TRELLO_KEY'], 
                       member_token: ENV['TRELLO_TOKEN']
                      ) 
    @board = @client.find(:boards, ENV['TRELLO_BOARD_ID'])
    delete_webhook(webhooks.first['id']) if webhooks.any? && webhooks.first['idModel'] != @board.id
    create_webhook if webhooks.empty?
  end

  def lists
    board.lists
  end

  def cards(list)
    list.cards
  end

  def create_card(name:, description: nil, list_id: lists.first.id)
    @client.create(:card, {
                            'name': name,
                            'desc': description,
                            'idList': list_id
                          }
                  )
  end

  def update_card(params)
    card = @client.find(:card, params['trello_id'])
    card.update_fields(
                        {
                          "name": params['name'],
                          "desc": params['description']
                        }
                      )
    card.update!
  end

  def destroy_card(id)
    card = @client.find(:card, id)
    card.delete
  end

  def create_list(name:)
    @client.create(:list, {
                            'name': name,
                            'idBoard': @board.id
                          }
                  )
  end

  def update_list(params)
    list = @client.find(:list, params['trello_id'])
    list.update_fields(
                        {
                          "name": params['name']
                        }
                      )
    list.update!
  end

  def webhooks
    res = Faraday.get("https://api.trello.com/1/tokens/#{ENV['TRELLO_TOKEN']}/webhooks?key=#{ENV['TRELLO_KEY']}")
    JSON.parse(res.body)
  end

  def create_webhook(model_id: board.id, callback_url: ENV['TRELLO_WEBHOOK_CALLBACK_URL'])
    @client.create(:webhook, {
                                'idModel': model_id,
                                'callbackURL': callback_url  
                             }
                  )
  end

  def delete_webhook(id)
    @client.find(:webhook, id).delete
  end
end