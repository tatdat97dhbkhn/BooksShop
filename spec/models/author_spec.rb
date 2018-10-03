require "rails_helper"

RSpec.describe Author, type: :model do
  describe "Center validations" do
    context "Column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
    end

    context "Validations" do
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name)
        .is_at_most(Settings.author.max_name)}
    end
  end

  describe "Associations" do
    it {should have_many(:books).dependent(:destroy)}
    it { should accept_nested_attributes_for(:books) }
  end

  describe "Search_by_Author" do
    before(:each) do
      FactoryBot.create(:author, name: "Pham Tat Dat")
    end

    it "return author if match name" do
      expect(Author.search_author("Pham Tat Dat").count).to eql 1
    end

    it "return author if name blank" do
      expect(Author.search_author("").count).to eql 1
    end

    it "return empty if name ot match" do
      expect(Author.search_author("Tat Dat").count).to eql 1
    end
  end

  describe "not vaild attributes" do
    subject {
      FactoryBot.build(:author)
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end
