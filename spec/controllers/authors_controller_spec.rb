require "rails_helper"

RSpec.describe AuthorsController, type: :controller do
  before :each do
    user = FactoryBot.build(:user)
    user.skip_confirmation!
    user.save
    sign_in user 
  end

  describe "GET #index" do
    subject {get :index}

    it "renders index template" do
      expect(subject).to render_template("authors/index")
    end

    it "does not render a different template" do
      expect(subject).to_not render_template("authors/show")
    end
  end

  describe "GET #new" do
    it "assigns a book to the new author" do
      get :new
      expect(:new).to render_template("authors/new")
    end
  end

  describe "POST create" do
    before(:each) do
      @cate = FactoryBot.create(:category, name: "Category 1")
      @author = FactoryBot.create(:author, name: "Author 1")
      @attrs = {name: "Dat", books_attributes: {name: "Ruby", price: 3,
        public_date: "2014-01-01 00:00:00.000000", category_id: @cate.id}}
    end
 
    subject {post :create, params: { author: @attrs}}

    context "with valid attributes" do
      it "creates a new author" do
        expect{
          post :create, params: {author: FactoryBot.attributes_for(:author)}
        }.to change(Author,:count).by(1)
      end
    end
		
    context "with invalid attributes" do
      it "does not save the new author" do
        expect{
          post :create, params: {author: FactoryBot.attributes_for(:invalid_author)}
        }.to_not change(Author,:count)
      end

      it "re-renders the new method" do
        post :create, params: {author: FactoryBot.attributes_for(:invalid_author)}
        expect(@rsponse).to render_template "authors/new"
      end
    end 
  end

  describe "DELETE #delete" do
    before(:each) do
      @author = FactoryBot.create(:author, name: "author 1")
    end

    it "delete author" do
      expect(Author.find_by(id: @author.id)).to be_present
      expect(Author.find_by(id: 0)).to_not be_present
      expect{
        delete :destroy, params: {id: @author.id}
      }.to change(Author,:count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end
