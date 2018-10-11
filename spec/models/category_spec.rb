require "rails_helper"

RSpec.describe Category, type: :model do
  describe "Center validation" do
    context "column_specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:description).of_type(:string)}
      it {is_expected.to have_db_column(:created_at).of_type(:datetime)}
      it {is_expected.to have_db_column(:updated_at).of_type(:datetime)}
    end

    context "validations" do
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(200)}
    end
  end

  describe "associations" do
    it { should have_many(:books) }
  end

  describe "not vaild attributes" do
    subject {FactoryBot.build(:category)}
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without length a name" do
      subject.name = "Long string"*200
      expect(subject).to_not be_valid
    end
  end
end
