json.extract! profile, :id, :user, :first_name, :last_name, :bio, :country, :city, :created_at, :updated_at
json.url profile_url(profile, format: :json)
