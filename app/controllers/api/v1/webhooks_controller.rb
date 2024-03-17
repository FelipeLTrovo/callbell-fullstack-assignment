class Api::V1::WebhooksController < ApplicationController
  def index
    render status: 200
  end

  def create
    case event_type

    when 'createCard'
      CardGenerator.generate_card(card_payload).save
            
    when 'updateCard'
      CardUpdater.new(card_payload).update_card

    when 'deleteCard'
      CardDestroyer.new(card_payload).destroy_card

    when 'createList'
      ListGenerator.generate_list(list_payload).save

    when 'updateList'
      ListUpdater.new(list_payload).update_list
    end
    render status: 200
  end

  private

  def event_type
    request.request_parameters['action']['type']
  end

  def card_payload
    return request.request_parameters['action']['data']['card'].merge({list_id: list_payload['id']}.with_indifferent_access) if list_payload.present?

    request.request_parameters['action']['data']['card']
  end

  def list_payload
    request.request_parameters['action']['data']['list']
  end
end
