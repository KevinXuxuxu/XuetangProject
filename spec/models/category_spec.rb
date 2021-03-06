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
      allow(Category).to receive(:all).and_return([@cat_1, @cat_2, @cat_3, @cat_4])
      result = Category.find_top_categories
      expect(result).to eq([@cat_1, @cat_2])
    end
  end

  describe "downward" do
    before :each do
      @tem_size = Category.find_top_categories.size
      @top_cat_1 = Category.create(name: "top_1", parent: nil)
      @top_cat_2 = Category.create(name: "top_2", parent: nil)
      @top_cat_3 = Category.create(name: "top_2", parent: nil)
      @sub_cat_1 = Category.create(name: "sub_1", parent: Category.find(@top_cat_1.id))
      @sub_cat_2 = Category.create(name: "sub_2", parent: Category.find(@top_cat_1.id))
      @sub_cat_3 = Category.create(name: "sub_3", parent: Category.find(@top_cat_1.id))
    end
    it "should be able to arrange top categories" do
      @top_cat_2.downward
      expect(Category.find(@top_cat_1.id).order).to eq(@tem_size + 1)
      expect(Category.find(@top_cat_2.id).order).to eq(@tem_size + 3)
      expect(Category.find(@top_cat_3.id).order).to eq(@tem_size + 2)
    end
    it "should be able to arrange sub categories" do
      @sub_cat_2.downward
      expect(Category.find(@sub_cat_1.id).order).to eq(1)
      expect(Category.find(@sub_cat_2.id).order).to eq(3)
      expect(Category.find(@sub_cat_3.id).order).to eq(2)
    end
    it "should leave the category unchanged if it is at bottom" do
      @sub_cat_3.downward
      expect(Category.find(@sub_cat_3.id).order).to eq(3)
    end
  end

  describe "upward" do
    before :each do
      @tem_size = Category.find_top_categories.size
      @top_cat_1 = Category.create(name: "top_1", parent: nil)
      @top_cat_2 = Category.create(name: "top_2", parent: nil)
      @top_cat_3 = Category.create(name: "top_2", parent: nil)
      @sub_cat_1 = Category.create(name: "sub_1", parent: Category.find(@top_cat_1.id))
      @sub_cat_2 = Category.create(name: "sub_2", parent: Category.find(@top_cat_1.id))
      @sub_cat_3 = Category.create(name: "sub_3", parent: Category.find(@top_cat_1.id))
    end
    it "should be able to arrange top categories" do
      @top_cat_2.upward
      expect(Category.find(@top_cat_1.id).order).to eq(@tem_size + 2)
      expect(Category.find(@top_cat_2.id).order).to eq(@tem_size + 1)
      expect(Category.find(@top_cat_3.id).order).to eq(@tem_size + 3)
    end
    it "should be able to arrange sub categories" do
      @sub_cat_2.upward
      expect(Category.find(@sub_cat_1.id).order).to eq(2)
      expect(Category.find(@sub_cat_2.id).order).to eq(1)
      expect(Category.find(@sub_cat_3.id).order).to eq(3)
    end
    it "should leave the category unchanged if it is at bottom" do
      @sub_cat_1.upward
      expect(Category.find(@sub_cat_1.id).order).to eq(1)
    end
  end

  describe "process_sub_cats" do
    before :each do
      @parent_cat = Category.create(name: 'parent', parent: nil)
      @sub_cat_1 = Category.create(name: 'sub_1', parent: @parent_cat)
      @sub_cat_2 = Category.create(name: 'sub_2', parent: @parent_cat)
      @sub_sub_cat = Category.create(name: 'grandson', parent: @sub_cat_1)
    end
    it "should be called before the destroy" do
      expect(@parent_cat).to receive(:process_sub_cats)
      @parent_cat.destroy
    end
    it "should move subcategories to its parent" do
      @sub_cat_1.destroy
      expect(Category.find(@sub_sub_cat.id).parent).to eq(@parent_cat)
    end
    it "should move subcategories to nil when the deleted node is root" do
      @parent_cat.destroy
      expect(Category.find(@sub_cat_1.id).parent).to eq(nil)
    end
    it "should set order properly" do
      @sub_cat_1.destroy
      expect(Category.find(@sub_sub_cat.id).order).to eq(2)
      expect(Category.find(@sub_cat_2.id).order).to eq(1)
    end
  end

  describe "set_proper_order" do
    before :each do
      @unspecified_list = {name: "cat"}
      @specified_list = {name: "cat", order: 10}
    end
    it "should be called before the create" do
      expect_any_instance_of(Category).to receive(:set_proper_order)
      Category.create(@unspecified_list)
    end
    it "should set proper even when specified" do
      size = Category.all.size
      new_cat = Category.create(@specified_list)
      expect(new_cat.order).to eq(size + 1)
    end
  end

end
