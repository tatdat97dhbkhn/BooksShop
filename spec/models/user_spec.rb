require "rails_helper"

RSpec.describe User, type: :model do
  describe "Center validations" do
    context "Column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:email).of_type(:string)}
    end

    context "Validations" do
      it {should validate_presence_of(:name)}
      it {should validate_presence_of(:email)}
      it {should validate_length_of(:name).is_at_most(Settings.user.max_name)}
    end
  end

  describe "not vaild attributes" do
    subject {
      FactoryBot.build(:user)
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = "123456"
      subject.password_confirmation = "12345"
      expect(subject).to_not be_valid
    end

    it "is not valid without length a name" do
      subject.name = "Long string"*200
      expect(subject).to_not be_valid
    end
  end
end
