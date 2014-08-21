json.array!(@messages) do |message|
  json.extract! message, :id, :kind, :url
  json.url message_url(message, format: :json)
end
