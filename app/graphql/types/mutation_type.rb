module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    # Post job
    field :create_job, mutation: Mutations::CreateJob,
      description: "Post a new job"
  end
end
