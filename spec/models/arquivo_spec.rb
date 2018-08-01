require 'rails_helper'

RSpec.describe Arquivo, type: :model do
    it{ is_expected.to validate_presence_of :name }
    it{ is_expected.to validate_presence_of :surname }
    it { should allow_value(Faker::Internet.email).for(:email) }
    it { should validate_numericality_of(:available_amount).
        is_greater_than_or_equal_to(0) }
end