json.extract! report, :id, :user, :post, :report_category, :comment, :created_at, :updated_at
json.url report_url(report, format: :json)
