json.array!(@uploads) do |upload|
  json.extract! upload, :id, :image
  json.url upload_url(upload, format: :json)
end
