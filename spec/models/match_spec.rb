require 'rails_helper'

RSpec.describe Match, type: :model do
  
    describe "Direct Associations" do

    it { should have_many(:comments) }

    it { should belong_to(:recipient_slot) }

    it { should belong_to(:sender_slot) }

    end

    describe "InDirect Associations" do

    it { should have_one(:receiving_user) }

    end

    describe "Validations" do
      
    end
end
