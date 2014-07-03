require 'rails_helper'

describe Category, :type => :model do
  before :each do
    @cat_1 = FactoryGirl.create(:category, name: "cat_1", id: 1)
    allow(@cat_1).to receive(:parent).and_return(nil)
    @cat_2 = FactoryGirl.create(:category, name: "cat_2", id: 2)
    allow(@cat_2).to receive(:parent).and_return(nil)
    @cat_3 = FactoryGirl.create(:category, name: "cat_3", id: 3)
    allow(@cat_3).to receive(:parent).and_return(@cat_1)
    @cat_4 = FactoryGirl.create(:category, name: "cat_4", id: 4)
    allow(@cat_4).to receive(:parent).and_return(@cat_1)
  end

  describe "subcategory relations" do
    before :each do
      @empty_cat = Category.create(name:'empty')
      @parent = Category.create(name: 'parent')
      @sub_cat_1 = Category.create(name: 'sub_1', parent: @parent)
      @sub_cat_2 = Category.create(name: 'sub_2', parent: @parent)
    end
    it "should return empty array when there is no children" do
      expect(@empty_cat.children).to eq([])
    end
    it "should return the array of children" do
      @parent = Category.find(@parent.id)
      expect(@parent.children).to eq([@sub_cat_1, @sub_cat_2])
    end
    it "should return nil when no parent" do
      expect(@parent.parent).to eq(nil)
    end
    it "should return the parent when specified" do
      expect(@sub_cat_1.parent).to eq(@parent)
    end
  end

  describe "find_top_categories" do
    it "should return all topcategories" do
      Category.stub(:all).and_return([@cat_1, @cat_2, @cat_3, @cat_4])
      result = Category.find_top_categories
      expect(result).to eq([@cat_1, @cat_2])
    end
  end

  describe "process_sub_cats" do
    before :each do
      @empty_cat = Category.create(name:'empty', parent: nil)
      @parent_cat = Category.create(name: 'parent', parent: nil)
      @sub_cat_1 = Category.create(name: 'sub_1', parent: @parent_cat)
      @sub_cat_2 = Category.create(name: 'sub_2', parent: @parent_cat)
      @sub_sub_cat = Category.create(name: 'grandson', parent: @sub_cat_1)
    end
    it "should be called before the destroy" do
      @empty_cat.should_receive(:process_sub_cats)
      @empty_cat.destroy
    end
    it "should do nothing when there is no subcategories" do
      @empty_cat.should_not_receive(:parent)
      @empty_cat.destroy
    end
    it "should move subcategories to its parent" do
      @sub_cat_1.destroy
      @parent_cat = Category.find(@parent_cat.id)
      expect(@parent_cat.children).to eq([@sub_cat_2, @sub_sub_cat])
    end
    it "should move subcategories to nil when the deleted node is root" do
      @parent_cat.destroy
      expect(Category.find(@sub_cat_1.id).parent).to eq(nil)
    end
  end

  describe "set_proper_order" do
    before :each do
      @unspecified_list = {name: "cat"}
      @specified_list = {name: "cat", order: 10}
    end
    it "should be called before the create" do
      Category.any_instance.should_receive(:set_proper_order)
      Category.create(@unspecified_list)
    end
  end

end
