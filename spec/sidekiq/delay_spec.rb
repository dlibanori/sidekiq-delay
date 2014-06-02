require "spec_helper"
require 'sidekiq/testing'
require 'sidekiq/delay'
require 'app/models/band'
require 'app/models/team'

describe Sidekiq::Delay do
  context "with default worker" do
    subject { Band.worker }
    let(:band) { Band.new }

    it { should eq(Sidekiq::Delay::Worker) }

    it "queues a job at default queue" do
      expect {
        band.delay.play
      }.to change(Sidekiq::Delay::Worker.jobs, :size).by(1)
    end
  end

  context "with custom worker" do
    subject { Team.worker }
    let(:team) { Team.new }

    it { should eq(TeamWorker) }

    it "queues a job at custom queue" do
      expect {
        team.delay.play
      }.to change(TeamWorker.jobs, :size).by(1)
    end
  end
end
