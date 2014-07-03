json.array!(@courses) do |course|
  json.extract! course, :id, :name, :description, :location, :ctime, :belong, :teacher
  json.url course_url(course, format: :json)
end
