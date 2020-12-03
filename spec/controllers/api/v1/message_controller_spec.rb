require 'rails_helper'

describe Api::V1::MessageController do
  let(:message) { create(:message) }
  let(:readed_message) { create(:message, :already_read) }

  describe '#show' do
    subject { get :show, params: show_params }

    context 'get message' do
      let(:show_params) { { id: message.uniq_key } }
      it 'return message' do
        expect(subject.status).to eq(200)
        expect(JSON.parse(subject.body)['message']).to eq('test message')
      end
    end

    context 'get message' do
      let(:show_params) { { id: '1233123-213123' } }
      it 'message not found' do
        expect(subject.status).to eq(404)
        expect(JSON.parse(subject.body)['error']).to eq('Message not found')
      end
    end

    context 'get message' do
      let(:show_params) { { id: readed_message.uniq_key } }
      it 'message already read' do
        expect(subject.status).to eq(404)
        expect(JSON.parse(subject.body)['error']).to eq('You already requasted this message')
      end
    end
  end

  describe '#create' do
    subject { post :create, params: message_params  }

    context 'with valid params' do
      let(:message_params) { { message: 'test message', has_password: true } }
      it { is_expected.to be_successful }
    end

    context 'without message ' do
      let(:message_params) { { message: nil, has_password: true } }
      it { is_expected.to have_http_status(:unprocessable_entity) }
    end

    context 'message too long' do
      let(:message_params) { { message: String.new('0' * 800) } }
      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end

  