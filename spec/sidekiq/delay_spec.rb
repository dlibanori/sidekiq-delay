require "spec_helper"
require 'sidekiq/testing'

require 'app/models/band'
require 'app/models/team'

describe Sidekiq::Delay do
  context "with default worker" do
    let(:band) { Band.new }

    it "queue an job at default queue" do
      expect {
        band.delay.play
      }.to change(Sidekiq::Delay::DefaultWorker.jobs, :size).by(1)
    end
  end

  context "with custom worker" do
    let(:team) { Team.new }

    it "queue an job at default queue" do
      expect {
        team.delay.play
      }.to change(TeamWorker.jobs, :size).by(1)
    end
  end
end
