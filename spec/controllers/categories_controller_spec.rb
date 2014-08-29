require 'rails_helper'

describe CategoriesController do

  before :each do
    @result_1 = FactoryGirl.build(:category, name: "One", id: 1)
    @result_2 = FactoryGirl.build(:category, name: "Two", id: 2)
    @result_3 = FactoryGirl.build(:category, name: "Three", id: 3)
    @sub_category = [@result_3]
    @top_category = [@result_1, @result_2]

    allow(Category).to receive(:find).with("1").and_return(@result_1)
    allow(Category).to receive(:find).with('2').and_return(@result_2)
    allow(Category).to receive(:find_top_categories).and_return(@top_category)
    allow(@result_1).to receive(:children).and_return(@sub_category)
    allow(@result_1).to receive(:validate).and_return(true)
    allow(@result_2).to receive(:validate).and_return(false)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
    it "should find find all top categories" do
     expect(Category).to receive(:find_top_categories).and_return(@top_category)
      get :index
      expect(assigns(:categories)).to eq(@top_category)
    end
  end

  describe "Show categories" do
    it "should access the database" do
      expect(Category).to receive(:find)
      get :show, {:id => 1}
    end
  end

  describe 'Validate' do
    it 'should redirect when not authorized' do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      get :show, {:id => 2}
      expect(response).to redirect_to 'where_i_came_from'
    end
  end
end
