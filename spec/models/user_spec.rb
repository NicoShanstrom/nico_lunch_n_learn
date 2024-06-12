require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { User.create(name: "User 1", email: "noemail@example.com", password: "password1", password_confirmation: "password1") }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:api_key) }
    it { should have_many(:favorites) }
  end

  describe "callback/instance method #create_unique_api_key" do
    it "creates a unique api_key before user creation" do
      user = User.new(name: "Paschi Dog", email: "getdatgroundhog@chase.com", password: "justletmechaseit", password_confirmation: "justletmechaseit")
      expect(user.api_key).to be_nil
      user.save
      expect(user.api_key).to be_present
    end

    it 'creates a unique api_key' do
      user1 = User.create(name: "User 1", email: "user1@example.com", password: "password1", password_confirmation: "password1")
      user2 = User.create(name: "User 2", email: "user2@example.com", password: "password2", password_confirmation: "password2")
      user3 = User.create(name: "Wolf", email: "wildone@toddlers.com", password: "momma", password_confirmation: "momma")
      user4 = User.create(name: "Jenna", email: "jenna@moms.com", password: "secret", password_confirmation: "secret")
      user5 = User.new(name: "Nico", email: "nico@dads.com", password: "secret", password_confirmation: "secret")
      user5.send(:create_unique_api_key)
      expect(user5.api_key).to be_present
      expect(User.exists?(api_key: user5.api_key)).to be false
    end
  end
end