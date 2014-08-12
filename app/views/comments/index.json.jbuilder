json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :author, :post
  json.url comment_url(comment, format: :json)
end
