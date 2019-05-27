json.extract! attachment, :id, :category_id, :post_id, :link, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
