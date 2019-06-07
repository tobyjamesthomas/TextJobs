module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    # Get all users
    field :users, [Types::UserType], null: false,
      description: "Get all users"
    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      description "Find user by id"
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end

    field :job, Types::JobType, null: false do
      description "Find job by id"
      argument :id, ID, required: true
    end
    def job(id:)
      Job.find(id)
    end
  end
end
