require "rails_helper"

RSpec.describe User, type: :model do
  subject {FactoryBot.build :user}
  
  describe "Associations" do
    it { is_expected.to have_many(:comments).dependent(:destroy)}
    it { is_expected.to have_many(:rates).dependent(:destroy)}
    it { is_expected.to have_many(:orders).dependent(:destroy)}
    it { is_expected.to have_many(:restaurants).dependent(:destroy)}
  end
  
  describe "image" do
    it { expect(subject.image).to be_attached}
  end

  describe "enum" do
    it { is_expected.to define_enum_for(:role).with_values([:admin, :boss, :normal])}
  end
  
  describe "has secure password" do
    it { is_expected.to have_secure_password }
  end
  
  describe "Validations" do
    it { is_expected.to validate_presence_of(:name).with_message(I18n.t("errors_blank")) }
    it { is_expected.to validate_presence_of(:email).with_message(I18n.t("errors_blank")) }
    it { is_expected.to validate_uniqueness_of(:email).with_message(I18n.t("errors_taken")) }
    it { is_expected.not_to allow_value("qwe@gmail").for(:email).with_message(I18n.t("invalid_errors")) }
    it { is_expected.to validate_presence_of(:password).with_message(I18n.t("errors_blank")) }
    it { is_expected.to validate_presence_of(:phone_number).with_message(I18n.t("errors_blank")) }
    
    context "name invalid" do
      before {subject.name = nil}
      it { is_expected.not_to be_valid }
    end

    context "Name greater than invalid" do
      before {subject.name = "a" * Settings.factories.user.name_max_length_invalid}
      it { is_expected.not_to be_valid }
    end

    context "Email invalid" do
      before {subject.email = nil}
      it { is_expected.not_to be_valid }
    end

    context "Email greater than invalid" do
      before {subject.email = "a" * Settings.factories.user.name_max_length_invalid}
      it { is_expected.not_to be_valid }
    end

    context "Password greater than invalid" do
      before {subject.password = "a" * Settings.factories.user.password_min_length_invalid}
      it { is_expected.not_to be_valid }
    end

    context "phone_number invalid" do
      before {subject.phone_number = nil}
      it { is_expected.not_to be_valid }
    end
  end
end
