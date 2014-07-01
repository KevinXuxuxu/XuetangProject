require 'rails_helper'

describe Category, :type => :model do
  before :each do
    @cat_1 = FactoryGirl.create(:category, name: "cat_1", id: 1)
    @cat_1.stub(:parent).and_return(nil)
    @cat_2 = FactoryGirl.create(:category, name: "cat_2", id: 2)
    @cat_2.stub(:parent).and_return(nil)
    @cat_3 = FactoryGirl.create(:category, name: "cat_3", id: 3)
    @cat_3.stub(:parent).and_return(@cat_1)
    @cat_4 = FactoryGirl.create(:category, name: "cat_4", id: 4)
    @cat_4.stub(:parent).and_return(@cat_1)
  end
  describe "find_top_categories" do
    it "should return all topcategories" do
      Category.stub(:all).and_return([@cat_1, @cat_2, @cat_3, @cat_4])
      result = Category.find_top_categories
      expect(result).to eq([@cat_1, @cat_2])
    end
  end
end
