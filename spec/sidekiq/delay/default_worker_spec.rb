require "spec_helper"
require "sidekiq/delay/default_worker"

Band = Class.new

describe Sidekiq::Delay::DefaultWorker do
  subject(:default_worker) { described_class.new }

  let(:band) { mock "Band", play: nil }
  let(:yml) { YAML.dump([[ Band, 1 ], :play, [ "get lucky", 10, 20 ]]) }

  before { Band.stub(find: band) }

  it "find an instance at class" do
    Band.should_receive(:find).with(1).and_return(band)
    default_worker.perform(yml)
  end

  it "calls play on instance" do
    band.should_receive(:play).with("get lucky", 10, 20)
    default_worker.perform(yml)
  end
end
