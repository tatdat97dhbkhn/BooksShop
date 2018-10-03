require "rails_helper"

RSpec.describe BooksController, type: :controller do
  let(:user) {
    user = FactoryBot.build(:user)
    user.password = "123456"
    user.skip_confirmation!
    user.save
    sign_in user 
  }

  describe "GET #index" do
    subject {get :index}

    it "renders index template" do
      user
      expect(subject).to render_template("books/index")
    end

    it "does not render a different template" do
      user
      expect(subject).to_not render_template("books/show")
    end
  end

  describe "GET #new" do
    it "assigns a book to the new book" do
      user
      get :new
      expect(:new).to render_template("books/new")
    end
  end

  describe "GET #home" do
    subject {get :home}

    it "renders home template" do
      expect(subject).to render_template("books/home")
    end
  end

  describe "POST #create" do
    before(:each) do
      user
      @cate = FactoryBot.create(:category, name: "Category 1")
      @author = FactoryBot.create(:author, name: "Author 1")
      @attrs = {name: "Dat", category_id: @cate.id, author_id: @author.id,
        description: "", image: "", price: 3, public_date: Time.now}
    end
 
    subject {post :create, params: { book: {name: "Dat",
      category_id: @cate.id, author_id: @author.id, description: "",
        image: "", price: 3, public_date: Time.now}}}

    context "with valid attributes" do
      it "creates a new book" do
        expect(subject).to redirect_to books_url
      end
    end

    context "with invalid attributes" do
      let(:book_invalid) {post :create,
        params: { book: {name: nil, category_id: @cate.id,
          author_id: @author.id, description: "", image: "", price: 3,
            public_date: Time.now}}}

      it "does not save the new book" do
        book =FactoryBot.build(:book, :name => nil)
        book.valid?
        expect(book.errors.count).to eq 1
        expect(book.errors[:name]).to include "can't be blank"
      end
      
      it "re-renders the new book" do
        post :create,
          params: {book: FactoryBot.attributes_for(:invalid_book)}
        expect(@rsponse).to render_template "books/new"
      end
    end
  end

  describe "DELETE #delete" do
    before(:each) do
      user
      @cate = FactoryBot.create(:category, name: "Category 1")
      @author = FactoryBot.create(:author, name: "Author 1")
      @book = FactoryBot.create(:book)
    end

    it "delete book" do
      expect(Book.find_by(id: @book.id)).to be_present
      expect{
        delete :destroy, params: { id: @book.id }
      }.to change(Book,:count).by(-1)
      expect(response.status).to eq(204)
    end
  end

  describe "PUT update" do
    before :each do
      user
      @book = FactoryBot.create(:book)
    end
    
    context "valid attributes" do
      it "located the requested @book" do
        @attr = { name: "Dat" }
        put :update, params: {id: @book.id, book: @attr}
        @book.reload
        expect(@book.name).to eq("Dat")
        expect(assigns[:book]).to_not be_new_record
        expect(response).to redirect_to books_path
      end
    end
    
    context "invalid attributes" do     
      it "locates the requested @book" do
        put :update, params: {id: @book.id,
          book: FactoryBot.attributes_for(:invalid_book)}
        expect(assigns(:book)).to eq(@book)      
      end
      
      it "does not change @book's attributes" do
        put :update, params: {id: @book.id, 
          book: FactoryBot.attributes_for(:book, name: "")}
        @book.reload
        expect(@book.name).not_to eq("")
      end
      
      it "re-renders the edit method" do
        put :update, params: {id: @book.id,
          book: FactoryBot.attributes_for(:invalid_book)}
        expect(@rsponse).to render_template "books/edit"
      end
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

    context "search_category" do
      it "return all book of category" do
        expect(@controller).to receive(:params)
          .and_return(category_id: @cate.id)
        expect(@controller.send(:select_search).count).to eq(3)
      end
    end

    context "search_author" do
      it "return all book of author" do
        expect(@controller).to receive(:params)
          .and_return(author_id: @author.id)
        expect(@controller.send(:select_search).count).to eq(3)
      end
    end

    context "search_date" do
      it "return date before_musty" do
        expect(@controller).to receive(:params).and_return(public_date: 1)
        expect(@controller.send(:select_search).count).to eq(0)
      end
  
      it "return date before_musty" do
        expect(@controller).to receive(:params).and_return(public_date: 2)
        expect(@controller.send(:select_search).count).to eq(1)
      end
  
      it "return date after_musty" do
        expect(@controller).to receive(:params).and_return(public_date: 3)
        expect(@controller.send(:select_search).count).to eq(2)
      end
    end

    context "search_price" do
      it "return date price_min" do
        expect(@controller).to receive(:params).and_return(price: 1)
        expect(@controller.send(:select_search).count).to eq(1)
      end
  
      it "return date price_medium" do
        expect(@controller).to receive(:params).and_return(price: 2)
        expect(@controller.send(:select_search).count).to eq(1)
      end
  
      it "return date price_max" do
        expect(@controller).to receive(:params).and_return(price: 3)
        expect(@controller.send(:select_search).count).to eq(1)
      end  
    end
  end

  describe "search_book" do
    let(:category) {
      FactoryBot.create(:category)
    }
    let(:author) {
      category
      FactoryBot.create(:author)
    }
    let(:book) {
      category
      author
      FactoryBot.create(:book, name: "dat")
    }
    context "search content" do
      it "return book have content" do
        expect(@controller).to receive(:params).and_return(name_search: "dat")
        expect(@controller.send(:search_book)).to match_array([book])
      end

      it "return book not have content" do
        expect(@controller).to receive(:params).and_return(name_search: "")
        expect(@controller.send(:search_book)).to match_array([])
      end
    end
  end

  describe "admin_search" do
    before :each do
      user
      @category1 = FactoryBot.create(:category, name: "cate1")
      @category2 = FactoryBot.create(:category, name: "cate2")
      @author1 = FactoryBot.create(:author, name: "author1")
      @author2 = FactoryBot.create(:author, name: "author2")
      @book1 = FactoryBot.create(:book, name: "bookp1", price: 4,
        public_date: "2014-01-01 00:00:00.000000",
        category_id: @category1.id, author_id: @author1.id)
      @book2 = FactoryBot.create(:book, name: "bookp2", price: 8,
        public_date: Date.new(2015, 1, 1),
        category_id: @category2.id, author_id: @author2.id)
    end
    context "search table author" do
      it "return all author" do
        get :admin_search, params: { table: "author" }
        expect(@controller.send(:admin_search))
          .to match_array([@author1, @author2])
      end

      it "return author have params[search]" do
        get :admin_search, params: { table: "author", search: "author1" }
        expect(@controller.send(:admin_search)).to match_array([@author1])
      end
    end

    context "search table category" do
      it "return all category" do
        get :admin_search, params: { table: "category" }
        expect(@controller.send(:admin_search))
          .to match_array([@category1, @category2])
      end

      it "return book have params[search]" do
        get :admin_search, params: { table: "category", search: "boo" }
        expect(@controller.send(:admin_search)).to match_array([])
      end
    end

    context "search table book" do
      it "return nill" do
        get :admin_search, params: { table: "book" }
        expect(@controller.send(:admin_search).to_a.count).to eq(0)
      end
    end
  end
end
