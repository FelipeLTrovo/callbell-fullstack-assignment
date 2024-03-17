require 'rails_helper'

RSpec.describe Api::V1::WebhooksController, type: :controller do
  before(:all) { Rails.application.load_seed }

  describe "POST /create" do
    it 'returns a createCard event' do
      expect(CardGenerator).to receive(:generate_card).with({"id"=>"65f4a9fa372ef7710e2f1204", "name"=>"Card name created by webhooks_spec"})
      expect { post :create, params: { action: {type: 'createCard', data: {card: {"id"=>"65f4a9fa372ef7710e2f1204", "name"=>"Card name created by webhooks_spec"}}} }}.to raise_error(NoMethodError, "undefined method `save' for nil:NilClass")
      expect(response).to be_successful
    end

    it 'returns a updateCard event' do
      expect(CardUpdater).to receive(:new).with({'id'=> Card.first.trello_id})
      expect { post :create, params: { action: {type: 'updateCard', data: {card: {id: Card.first.trello_id}}} }}.to raise_error(NoMethodError, "undefined method `update_card' for nil:NilClass")
      expect(response).to be_successful
    end

    it 'returns a updateCard event' do
      expect(CardDestroyer).to receive(:new).with({'id'=> Card.first.trello_id})
      expect { post :create, params: { action: {type: 'deleteCard', data: {card: {id: Card.first.trello_id}}} }}.to raise_error(NoMethodError, "undefined method `destroy_card' for nil:NilClass")
      expect(response).to be_successful
    end

    it 'returns a createList event' do
      expect(ListGenerator).to receive(:generate_list).with({"id"=>"65f4a9fa372ef7710e2f1204", "name"=>"List name created by webhooks_spec"})
      expect { post :create, params: { action: {type: 'createList', data: {list: {"id"=>"65f4a9fa372ef7710e2f1204", "name"=>"List name created by webhooks_spec"}}} }}.to raise_error(NoMethodError, "undefined method `save' for nil:NilClass")
      expect(response).to be_successful
    end

    it 'returns a updateList event' do
      expect(ListUpdater).to receive(:new).with({'id'=> List.first.trello_id})
      expect { post :create, params: { action: {type: 'updateList', data: {list: {id: List.first.trello_id}}} }}.to raise_error(NoMethodError, "undefined method `update_list' for nil:NilClass")
      expect(response).to be_successful
    end
  end
end
