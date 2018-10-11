require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  before :each do
    user = FactoryBot.build(:user)
    user.skip_confirmation!
    user.save
    sign_in user 
  end

  describe "GET #new" do
    it "assigns a category to the new category" do
      get :new
      expect(:new).to render_template("categories/new")
    end
  end

  describe "POST create" do
    subject {post :create, params: { category: {name: "category"}}}
      context "with valid attributes" do
        it "creates a new category" do
          expect{
            post :create,
              params: {category: FactoryBot.attributes_for(:category)}
          }.to change(Category,:count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new category" do
          expect{
            post :create,
              params: {category: FactoryBot.attributes_for(:invalid_category)}
          }.to_not change(Category,:count)
        end

        it "re-renders the new method" do
          post :create,
          params: {category: FactoryBot.attributes_for(:invalid_category)}
          expect(@rsponse).to render_template "categories/new"
        end
      end 
    end

  describe "DELETE #delete" do
    before(:each) do
      @cate = FactoryBot.create(:category, name: "Category 1")
    end

    it "delete category" do
      expect(Category.find_by(id: @cate.id)).to be_present
      expect{
        delete :destroy, params: { id: @cate.id }
      }.to change(Category,:count).by(-1)
      expect(response.status).to eq(204)
    end
  end

  describe "PUT update" do
    before :each do
      @category = FactoryBot.create(:category)
    end
    
    context "valid attributes" do
      it "located the requested @category" do
        @attr = { name: "Dat" }
        put :update, params: {id: @category.id, category: @attr}
        @category.reload
        expect(@category.name).to eq("Dat")
        expect(assigns[:category]).to_not be_new_record
        expect(response).to redirect_to categories_path
      end
    end

    context "invalid attributes" do     
      it "locates the requested @category" do
        put :update, params: {id: @category.id,
          category: FactoryBot.attributes_for(:invalid_category)}
        expect(assigns(:category)).to eq(@category)      
      end
      
      it "does not change @category's attributes" do
        put :update, params: {id: @category.id, 
          category: FactoryBot.attributes_for(:category, name: "")}
        @category.reload
        expect(@category.name).not_to eq("")
      end
      
      it "re-renders the edit method" do
        put :update, params: {id: @category.id,
          category: FactoryBot.attributes_for(:invalid_category)}
        expect(@rsponse).to render_template "categories/edit"
      end
    end
  end
end
