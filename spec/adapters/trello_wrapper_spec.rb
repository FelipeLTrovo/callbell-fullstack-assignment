require 'rails_helper'

RSpec.describe TrelloWrapper, type: :model do
  before(:all) do
    Rails.application.load_seed
    @client = TrelloWrapper.new
  end

  describe '#board' do
    it 'return a trello board' do  
      expect(@client.board).to be_a(Trello::Board)
    end
  end

  describe '#create_list' do
    it 'creates a list on trello' do
      current_lists_count = @client.lists.size
      @client.create_list(name: 'Trello list test')
      
      expect(@client.lists.size).to eq(current_lists_count + 1)
    end
  end

  describe '#create_card' do
    it 'creates a card on trello' do
      current_cards_count = @client.cards(@client.lists.first).size

      @client.create_card(name: 'Card created by trello_wrapper_spec')

      expect(@client.cards(@client.lists.first).size).to eq(current_cards_count + 1)
    end
  end

  describe '#webhooks' do
    it 'returns all webhooks must have at least the board one' do

      webhooks = @client.webhooks

      expect(webhooks.size).to be >= 1
      expect(webhooks.first['callbackURL']).to eq(ENV['TRELLO_WEBHOOK_CALLBACK_URL'])
    end
  end  
end