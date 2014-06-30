FactoryGirl.define do
  factory :category do
    name "Unknown_category"
    parent 0
    children {[]}
    articles {[]}
  end
end
