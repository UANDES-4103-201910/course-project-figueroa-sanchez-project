json.extract! post, :id, :profile, :title, :descrption, :created_at, :updated_at
json.url post_url(post, format: :json)
