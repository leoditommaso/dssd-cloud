json.array!(@view_files) do |view_file|
  json.extract! view_file, :id
  json.url view_file_url(view_file, format: :json)
end
