require "spec_helper"
require 'sidekiq/testing'

require 'sidekiq/delay'
require 'app/models/band'
require 'app/models/team'

describe Sidekiq::Delay do
  context "with default worker" do
    subject { Band }
    let(:band) { Band.new }
    let(:worker) { Sidekiq::Delay::Worker }

    its(:worker) { should eq(worker) }

    it "queues a job at default queue" do
      expect {
        band.delay.play
      }.to change(Sidekiq::Delay::Worker.jobs, :size).by(1)
    end
  end

  context "with custom worker" do
    subject { Team }
    let(:team) { Team.new }
    let(:worker) { TeamWorker }

    its(:worker) { should eq(worker) }

    it "queues a job at custom queue" do
      expect {
        team.delay.play
      }.to change(TeamWorker.jobs, :size).by(1)
    end
  end
end
