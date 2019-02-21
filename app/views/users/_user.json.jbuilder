json.extract! user, :id, :phone, :first_name, :store, :coffee, :call_center, :created_at, :updated_at
json.url user_url(user, format: :json)