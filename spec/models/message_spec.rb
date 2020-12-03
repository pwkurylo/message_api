require 'rails_helper'

describe Message do
  let(:message) { create(:message) }

  describe 'validations' do
    subject { message }

    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:uniq_key) }
  end

  describe '#read' do
    subject { message.read }

    it { is_expected.to be_truthy }   
  end
end