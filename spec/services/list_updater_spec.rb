require 'rails_helper'

RSpec.describe ListUpdater, type: :model do
  describe '#update_list' do
    it 'updates a list' do

      list = ListGenerator.generate_list({'name'=> 'List Name', 'id'=> 'asdfg123456'})
      list.save
      ListUpdater.new({'name'=> 'New List Name', 'id'=> list.id }).update_list
      list.reload
      
      expect(list.name).to eq('New List Name')
      expect(list.trello_id).to eq('asdfg123456')
    end
  end
end