module Mutations
  class CreateJob < BaseMutation
    # Arguments passed to the `resolved` method
    argument :employer, String, required: true
    argument :title, String, required: true
    argument :location, String, required: true
    argument :wage, Int, required: true
    argument :expiry, String, required: false
    argument :link, String, required: true
    argument :job_type_id, ID, required: true

    # Fields returned in query
    field :id, ID, null: false
    field :employer, String, null: false
    field :title, String, null: false
    field :location, String, null: false
    field :wage, Int, null: false
    field :expiry, String, null: false
    field :link, String, null: false
    field :sent_to, [Types::UserType], null: false
    field :seen_by, [Types::UserType], null: false

    def resolve(employer: nil, title: nil, location: nil,
      wage: nil, expiry: nil, link: nil, job_type_id: nil)
      # Create job
      job = Job.new(
        employer: employer,
        title: title,
        location: location,
        wage: wage,
        expiry: expiry.nil? ? Date.today+7 : expiry,
        link: link,
        job_type_id: job_type_id
      )

      if job.save
        # Send texts
        job.send_texts

        # Return fields in hash
        {
          id: job.id,
          employer: job.employer,
          title: job.title,
          location: job.location,
          wage: job.wage,
          expiry: job.expiry,
          link: job.link,
          sent_to: job.sent_to,
          seen_by: job.seen_by,
        }
      else
        raise GraphQL::ExecutionError, job.errors.full_messages.join(", ")
      end
    end
  end
end
