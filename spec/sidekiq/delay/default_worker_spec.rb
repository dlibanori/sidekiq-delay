require "spec_helper"
require "sidekiq/delay/default_worker"

describe Sidekiq::Delay::DefaultWorker do
  subject { described_class }

  let(:strategy) { Sidekiq::Delay::DefaultStrategy }
  let(:worker) { Sidekiq::Worker }

  its(:ancestors) { should include(strategy) }
  its(:ancestors) { should include(worker) }
end
