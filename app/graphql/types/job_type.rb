module Types
  class JobType < Types::BaseObject
    description "A job"

    # ID
    field :id, ID, null: false

    # Employer
    field :employer, String, null: false

    # Title
    field :title, String, null: false

    # Location
    field :location, String, null: false

    # Wage
    field :wage, Int, null: false

    # Expiry
    field :expiry, String, null: false

    # Link
    field :link, String, null: false

    # Users job was sent to
    field :sent_to, [Types::UserType], null: false

    # Users who have clicked on link
    field :seen_by, [Types::UserType], null: false
  end
end
