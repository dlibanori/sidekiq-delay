require "spec_helper"
require "sidekiq/delay/worker"

describe Sidekiq::Delay::Worker do
  subject { described_class.ancestors }

  let(:strategy) { Sidekiq::Delay::Strategy }
  let(:worker) { Sidekiq::Worker }

  it { should include(strategy) }
  it { should include(worker) }
end
