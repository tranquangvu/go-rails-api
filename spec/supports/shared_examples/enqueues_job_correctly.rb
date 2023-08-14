RSpec.shared_examples 'enqueues_job_correctly' do |queue, *args, **kargs|
  it 'enqueues job correctly' do
    expect { described_class.perform_later(*args, **kargs) }.to have_enqueued_job.with(*args, **kargs).on_queue(queue)
  end
end
