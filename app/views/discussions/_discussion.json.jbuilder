json.extract! discussion, :id, :description, :topic, :created_at, :updated_at
json.url discussion_url(discussion, format: :json)
