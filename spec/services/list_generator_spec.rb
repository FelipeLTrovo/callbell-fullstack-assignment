require 'rails_helper'

RSpec.describe ListGenerator, type: :model do
  describe '.generate_list' do
    it 'generates a list' do

      list = ListGenerator.generate_list({'name'=> 'List Name', 'id'=> 'asdfg123456'})
      
      expect(list).to be_a(List)
      expect { list.save }.to change(List, :count).by(1)
      expect(list.name).to eq('List Name')
      expect(list.trello_id).to eq('asdfg123456')
    end
  end
end