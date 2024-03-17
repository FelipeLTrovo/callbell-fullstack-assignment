require 'rails_helper'

RSpec.describe CardDestroyer, type: :model do
  before(:all) { Rails.application.load_seed }

  describe '#destroy_card' do
    it 'deletes a card from database' do

      card = CardGenerator.generate_card({'name'=> 'Card Name'})
      
      expect(card).to be_a(Card)
      expect { card.save }.to change(Card, :count).by(1)
      card.reload
      expect { CardDestroyer.new({'id' => card.id}).destroy_card }.to change(Card, :count).by(-1)
    end
  end
end