require 'rails_helper'

RSpec.describe CardGenerator, type: :model do
  before(:all) { Rails.application.load_seed }

  describe '.generate_card' do
    it 'should not generate a card if the list_id is not provided' do

      card = CardGenerator.generate_card({'name'=> 'Card Name'})
      
      expect(card).to be_a(Card)
      expect { card.save }.to change(Card, :count).by(0)
    end

    it 'generates a card linked to the specified list when the list payload is provided' do
      list = List.create(name: 'List test', trello_id: '123asdf')
      card = CardGenerator.generate_card({'name'=> 'Card Name', 'list_id'=> '123asdf'})
      
      expect(card).to be_a(Card)
      expect { card.save }.to change(Card, :count).by(1)
      expect(card.name).to eq('Card Name')
      expect(card.list).to eq(list)
    end
  end
end