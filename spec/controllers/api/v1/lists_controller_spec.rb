require 'rails_helper'

RSpec.describe Api::V1::ListsController, type: :controller do
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
      post :create, params: { list: {name: 'List name created by list_spec'}}
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns a unsuccessful response when invalid params' do
      post :create, params: { list: {wrong_param: 'Wrong param'}}
      expect(response).to be_successful
      expect(response.status).not_to eq(200)
    end
  end

  describe "PUT /update" do
    it 'returns a successful response' do
      put :update, params: { id: List.first.id, list: {name: 'List name created by list_spec update', id: List.first.id}}
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns a unsuccessful response when invalid params' do
      put :update, params: {id: List.first.id, list: {wrong_param: 'Wrong param', id: List.first.id}}
      expect(response).to be_successful
      expect(response.status).not_to eq(200)
    end
  end
end
