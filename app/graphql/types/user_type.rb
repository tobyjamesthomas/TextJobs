module Types
  class UserType < Types::BaseObject
    description "A user"

    # ID
    field :id, ID, null: false

    # first_name
    field :first_name, String, null: false

    # phone number
    field :phone, String, null: false

    # Jobs received
    field :jobs_received, [Types::JobType], null: false
  end
end
