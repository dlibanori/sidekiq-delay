require "spec_helper"
require "sidekiq/delay/strategy"

describe Sidekiq::Delay::Strategy do
  Game = Class.new
  GameWorker = Class.new { include Sidekiq::Delay::Strategy }

  subject(:worker) { GameWorker.new }

  let(:game) { double "Game", play: nil }
  let(:yml) { YAML.dump([[ Game, 1 ], :play, [ "get lucky", 10, 20 ]]) }

  context "#perfom" do
    before { allow(worker).to receive(:record) { game }}

    it "calls record to find instance" do
      expect(worker).to receive(:record).with(Game, 1)
      worker.perform(yml)
    end

    it "calls play on instance" do
      expect(game).to receive(:play).with("get lucky", 10, 20)
      worker.perform(yml)
    end
  end

  context "#record" do
    before { allow(Game).to receive(:find) { game }}

    it "finds an instance at class" do
      expect(Game).to receive(:find).with(1)
      worker.record(Game, 1)
    end
  end
end
