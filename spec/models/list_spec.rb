require 'rails_helper'

RSpec.describe List, type: :model do
  it "should not save a list without a name" do
    list = List.new

    expect { list.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
