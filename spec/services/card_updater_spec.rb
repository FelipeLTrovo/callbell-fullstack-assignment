require 'rails_helper'

RSpec.describe CardUpdater, type: :model do
  describe '#update_card' do
    it 'updates a card including its list_id if list_id is present in payload' do

      list = ListGenerator.generate_list({'name'=> 'List Name', 'id'=> 'asdfg123456'})
      card = CardGenerator.generate_card({'name'=> 'Card Name', 'list_id'=> '123asdf'})
      card.list = list
      card.save
      new_list = ListGenerator.generate_list({'name'=> 'New List Name', 'id'=> 'new_list_id'})
      new_list.save
      CardUpdater.new({'name'=> 'New Card Name', 'id'=> card.id, 'list_id'=>'new_list_id'}).update_card
      card.reload
      
      expect(card.name).to eq('New Card Name')
      expect(card.list).to eq(new_list)
    end

    it 'updates a card and does not change its list_id if list_id is not present in payload' do

      list = ListGenerator.generate_list({'name'=> 'List Name', 'id'=> 'asdfg123456'})
      card = CardGenerator.generate_card({'name'=> 'Card Name', 'id'=> '123asdf'})
      card.list = list
      card.save
      new_list = ListGenerator.generate_list({'name'=> 'New List Name', 'id'=> 'new_list_id'})
      new_list.save
      CardUpdater.new({'name'=> 'New Card Name', 'id'=> card.id }).update_card
      card.reload
      
      expect(card.name).to eq('New Card Name')
      expect(card.list).to eq(list)
      expect(card.list).to_not eq(new_list)
    end
  end
end