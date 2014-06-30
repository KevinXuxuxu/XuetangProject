require 'rails_helper'

describe CategoriesController do

  before :each do
    @result_1 = FactoryGirl.build(:category, name: "One", id: 1)
    @result_2 = FactoryGirl.build(:category, name: "Two", id: 2)
    @result_3 = FactoryGirl.build(:category, name: "Three", id: 3)
    @sub_category = [@result_3]
    @top_category = [@result_1, @result_2]

    Category.stub(:find).with("1").and_return(@result_1)
    Category.stub(:find_top_categories).and_return(@top_category)
    @result_1.stub(:children).and_return(@sub_category)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "should find all categories" do
      Category.should_receive(:all)
      get 'index'
    end
  end

  describe "Show categories" do
    it "should access the database" do
      Category.should_receive(:find)
      get :show, {:id => 1}
    end

    it "should find find all top categories" do
      Category.should_receive(:find_top_categories)
      get :show, {:id => 1}
      assigns(:top_category).should == @top_category
    end

    it "should return articles under the categories" do
      @result_1.should_receive(:articles)
      get :show, {:id => 1}
      assigns(:sub_category).should_not be_nil
    end

    it "should return subcategories" do
      Category.should_receive(:find_sub_categories)
      get :show, {:id => 1}
      assigns(:sub_category).should == @sub_category
    end

    it "should find the parent" do
      Category.should_receive(:find).with("3").and_return(@result_3)
      Category.should_receive(:find).with(1).and_return(@result_1)
      get :show, {:id => 3}
      assigns(:trace_category).should == [@result_1]
    end
  end

end
