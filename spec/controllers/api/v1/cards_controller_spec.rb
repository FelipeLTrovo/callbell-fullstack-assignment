require 'rails_helper'

RSpec.describe Api::V1::CardsController, type: :controller do
  before(:all) { Rails.application.load_seed }

  describe "GET /index" do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end

  describe "POST /create" do
    it 'returns a successful response' do
      post :create, params: { card: {name: 'Card name created by cards_spec', list_id: List.first.trello_id}}
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns a unsuccessful response when invalid params' do
      post :create, params: { card: {wrong_param: 'Wrong param'}}
      expect(response).to be_successful
      expect(response.status).not_to eq(200)
    end
  end

  describe "PATCH /update" do
    it 'returns a successful response' do
      patch :update, params: { id: Card.last.id, card: {name: 'Card name created by cards_spec update', id: Card.last.id, trello_id: Card.last.trello_id}}
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns a unsuccessful response when invalid params' do
      patch :update, params: {id: Card.first.id, card: {name: '', id: Card.first.id, trello_id: Card.first.trello_id}}
      expect(response).to be_successful
      expect(response.status).not_to eq(200)
    end
  end

  describe "DELETE /destroy" do
    it 'returns a successful response' do
      delete :destroy, params: {id: Card.last.id, card: {id: Card.last.trello_id}}
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns an error when invalid params' do
      expect {delete :destroy, params: { wrong_param: 'abc123' }}.to raise_error(ActionController::UrlGenerationError)
    end
  end
end
