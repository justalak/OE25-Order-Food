require "rails_helper"

RSPEC.describe Order, type: :model do
  let!(:user) {FactoryBot.create :user}
  let!(:restaurant) {FactoryBot.create :restaurant}
  subject {FactoryBot.build :order, user_id: user.id, restaurant_id: restaurant.id}

  describe "Create" do 
    it {expect(subject).to belong_to :restaurant}
    it {expect(subject).to belong_to :user}
  end

  describe "Association" do 
    before do
      subject.user_id = user.id
      subject.restaurant_id = restaurant.id
    end
    it {expect(subject.user).to eq(user) }
    it {expect(subject.restaurant).to eq(restaurant) }
  end

  describe "Validations" do
    it { expect(subject).to validate_numericality_of(:user_id).with_message(I18n.t("errors_not_a_number"))}
    it { expect(subject).to validate_numericality_of(:restaurant_id).with_message(I18n.t("errors_not_a_number"))}