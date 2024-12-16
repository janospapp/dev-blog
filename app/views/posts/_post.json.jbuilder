json.extract! post, :id, :title, :summary, :body, :published_at, :body_updated_at
json.url post_url(post, format: :json)
