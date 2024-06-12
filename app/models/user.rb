class User < ApplicationRecord
  has_secure_password

  has_many :favorites, dependent: :destroy

  before_validation :create_unique_api_key, on: :create

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :api_key, presence: true

  private

  def create_unique_api_key
    loop do
      self.api_key = SecureRandom.hex(24)
      break unless self.class.exists?(api_key: api_key)
    end
  end
end