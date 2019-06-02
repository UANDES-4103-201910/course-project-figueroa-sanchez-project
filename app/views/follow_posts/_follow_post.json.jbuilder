json.extract! follow_post, :id, :user, :post, :created_at, :updated_at
json.url follow_post_url(follow_post, format: :json)
