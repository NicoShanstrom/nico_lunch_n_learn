require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "validations" do
    before do
      user = User.create(name: "User 1", email: "noemail@example.com", password: "password1", password_confirmation: "password1")
      favorite_recipe = user.favorites.create(country: "Morocco", recipe_link: "http://www.moroccoyum.com/good_recipe", recipe_title: "You haven't had this before")
    end

    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:recipe_link) }
    it { should validate_presence_of(:recipe_title) }
    it { should belong_to(:user) }
  end
end
