require_relative 'tower_of_hanoi'

describe TowerOfHanoi do
  describe "#valid_move?" do
    context "when moving a larger disk onto a smaller disk" do
      it "returns false" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [3], 'B' => [1], 'C' => [2] })
        expect(game.valid_move?('A', 'B')).to be false
      end
    end

    context "when moving a smaller disk onto a larger disk" do
      it "returns true" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [1], 'B' => [3], 'C' => [2] })
        expect(game.valid_move?('A', 'B')).to be true
      end
    end

    context "when moving from an empty tower" do
      it "returns false" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [2, 1], 'B' => [], 'C' => [3] })
        expect(game.valid_move?('B', 'C')).to be false
      end
    end

    context "when moving to an empty tower" do
      it "returns true" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [2, 1], 'B' => [3], 'C' => [] })
        expect(game.valid_move?('A', 'C')).to be true
      end
    end
  end

  describe "#move" do
    context "when making a valid move" do
      it "moves a disk from the source tower to the destination tower" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [3, 2], 'B' => [1], 'C' => [] })
        expect(game.move('A', 'C')).to be true
        expect(game.instance_variable_get(:@towers)).to eq({ 'A' => [3], 'B' => [1], 'C' => [2] })
      end
    end

    context "when making an invalid move" do
      it "does not move a disk and returns false" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [3], 'B' => [1], 'C' => [2] })
        expect(game.move('A', 'B')).to be false
        expect(game.instance_variable_get(:@towers)).to eq({ 'A' => [3], 'B' => [1], 'C' => [2] })
      end
    end
  end

  describe "#won?" do
    context "when all disks are on the second or third tower" do
      it "returns true" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [], 'B' => [], 'C' => [3, 2, 1] })
        expect(game.won?).to be true
      end
    end

    context "when not all disks are on the second or third tower" do
      it "returns false" do
        game = TowerOfHanoi.new(3)
        game.instance_variable_set(:@towers, { 'A' => [3], 'B' => [2], 'C' => [1] })
        expect(game.won?).to be false
      end
    end
  end
end
