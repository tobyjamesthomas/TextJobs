json.extract! job, :id, :employer, :title, :job_type_id, :description, :location, :wage, :expiry, :link, :created_at, :updated_at
json.url job_url(job, format: :json)