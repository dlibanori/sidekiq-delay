require "spec_helper"
require "sidekiq/delay/worker"

describe Sidekiq::Delay::Worker do
  subject { described_class }

  let(:strategy) { Sidekiq::Delay::Strategy }
  let(:worker) { Sidekiq::Worker }

  its(:ancestors) { should include(strategy) }
  its(:ancestors) { should include(worker) }
end
