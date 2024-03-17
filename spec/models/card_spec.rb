require 'rails_helper'

RSpec.describe Card, type: :model do
  it "should not save a card without a name" do
    card = Card.new
    card.description = 'Card description'
    card.list = List.new
    expect { card.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
