require "rails_helper"

RSpec.describe Book, type: :model do
  describe "Center validations" do
    context "Column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:description).of_type(:text)}
      it {is_expected.to have_db_column(:price).of_type(:float)}
      it {is_expected.to have_db_column(:public_date).of_type(:datetime)}
      it {is_expected.to have_db_column(:image).of_type(:string)}
      it {is_expected.to have_db_column(:author_id).of_type(:integer)}
      it {is_expected.to have_db_column(:category_id).of_type(:integer)}
    end

    context "Validations" do
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(Settings.book.max_name)}
      it {should validate_presence_of(:price)}
      it {should validate_presence_of(:public_date)}
      it {should validate_presence_of(:category_id)}
    end
  end

  describe "Associations" do
    it {is_expected.to belong_to(:author)}
    it {is_expected.to belong_to(:category)}
  end

  describe "#find_category" do
    before :each do
      @cate = FactoryBot.create(:category, name: "Category 1")
      @author = FactoryBot.create(:author, name: "Author 1")
      @book1 = FactoryBot.create(:book)
      @book2 = FactoryBot.create(:book)
    end

    it "return book if match" do
      expect(Book.find_category(@cate.id).count).to eql 2
    end

    it "return empty if name ot match" do
      expect(Book.find_category(10).count).to eql 0
      # Book.find_category(category.id).should == [book]
    end
  end

  describe "#find_author" do
    before :each do
      @cate = FactoryBot.create(:category, name: "Category 1")
      @author = FactoryBot.create(:author, name: "Author 1")
      @book1 = FactoryBot.create(:book)
      @book2 = FactoryBot.create(:book)
    end

    it "return book if match" do
      expect(Book.find_author(@author.id).count).to eql 2
    end

    it "return empty if name ot match" do
      expect(Book.find_author(10).count).to eql 0
    end
  end

  describe "search_date_price" do
    before :each do
      @cate = FactoryBot.create(:category, name: "Category 1")
      @author = FactoryBot.create(:author, name: "Author 1")
      @book1 = FactoryBot.create(:book, name: "bookp1", price: 4,
        public_date: "2014-01-01 00:00:00.000000",
        category_id: @cate.id, author_id: @author.id)
      @book2 = FactoryBot.create(:book, name: "bookp2", price: 8,
        public_date: Date.new(2015, 1, 1),
        category_id: @cate.id, author_id: @author.id)
      @book3 = FactoryBot.create(:book, name: "bookp3", price: 11,
        public_date: Time.now,
        category_id: @cate.id, author_id: @author.id)
    end

    context "search_date" do
      it "return date before_musty" do
        expect(Book.before_musty.count).to eql 0
      end
  
      it "return date before_musty" do
        expect(Book.middle_musty.count).to eql 1
      end
  
      it "return date after_musty" do
        expect(Book.after_musty.count).to eql 2
      end
    end

    context "search_price" do
      it "return date price_min" do
        expect(Book.price_min.count).to eql 1
      end
  
      it "return date price_medium" do
        expect(Book.price_medium.count).to eql 1
      end
  
      it "return date price_max" do
        expect(Book.price_max.count).to eql 1
      end  
    end
  end

  describe "search_content_filter" do
    before(:each) do
      @cate1 = FactoryBot.create(:category, name: "Education")
      @cate2 = FactoryBot.create(:category, name: "Music")
      @author1 = FactoryBot.create(:author, name: "Edu Mark")
      @author2 = FactoryBot.create(:author, name: "Tat Dat")
      @book1 = FactoryBot.create(:book, name: "du", price: 4,
        public_date: Date.new(2011, 1, 1), category_id: @cate1.id,
        author_id: @author1.id, description: "dumasaigon")
    end
    context "search_content" do
      it "content search match" do
        expect(Book.search_books("du").count).to eql 1
      end

      it "not match" do
        expect(Book.search_books("dat").count).to eql 0
      end
    end

    context "filter_book" do
      it "have record when filter" do
        expect(Book.search(category_id: @cate1.id).count).to eql 1
        expect(Book.search(category_id: @cate1.id, author_id: @author1.id)
          .count).to eql 1
      end

      it "do not have record" do
        expect(Book.search(category_id: @cate2.id).count).to eql 0
      end

      it "return all books when search" do
        expect(Book.search(category_id: "", author_id: "",
          price: "", public_date: "").count).to eql 1
      end
    end
  end

  describe "not vaild attributes" do
    let(:category) {FactoryBot.create(:category)}
    let(:author) {FactoryBot.create(:author)}
    subject {
      category
      author
      FactoryBot.build(:book)
    }

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

    it "is not valid without a price" do
      subject.price = nil
      expect(subject).to_not be_valid  
    end

    it "is not valid without a public_date" do
      subject.public_date = nil
      expect(subject).to_not be_valid  
    end

    it "is not valid without a category_id" do
      subject.category_id = nil
      expect(subject).to_not be_valid  
    end

    it "is not valid without a image" do
      subject.image = File.new(Rails.root + "spec/models/book_spec.rb")
      expect(subject).to_not be_valid
    end
  end
end
