require 'test_helper'

class Mutations::CreateJobTest < ActiveSupport::TestCase
  def setup
    JobType.create(name: "coffee")
  end

  def perform(**args)
    Mutations::CreateJob.new(object: nil, context: {}).resolve(args)
  end

  test 'create new job' do
    # Run setup to create JobType
    setup()

    # Create job
    job = perform(
      employer: "Human Startup",
      title: "Barista",
      location: "Toronto",
      wage: 12,
      expiry: Date.today,
      link: "https://humanstartup.ca/",
      job_type_id: JobType.last.id
    )
    
    # Assert
    assert_equal job[:employer], 'Human Startup'
    assert_equal job[:title], 'Barista'
    assert_equal job[:location], 'Toronto'
    assert_equal job[:wage], 12
    assert_equal job[:expiry], Date.today
    assert_equal job[:link], 'https://humanstartup.ca/'
  end
end
