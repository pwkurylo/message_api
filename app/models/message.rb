class Message < ApplicationRecord
  include Encrypt

  validates :message, :uniq_key, presence: true
  validates :uniq_key, uniqueness: true
  validates_length_of :message, :maximum => 2000

  before_create :encrypt_message

  before_validation(on: :create) do
    self.uniq_key = generate_uniq_key
  end

  def encrypt_message
    self.message = encrypt(ENV['ENCRYPT_KEY'], self.message)
  end

  def generate_uniq_key
    loop do
      uniq_key = SecureRandom.uuid
      break uniq_key unless Message.find_by(uniq_key: uniq_key)
    end
  end

  def read
    self.update(read_at: Time.now)
  end
end
