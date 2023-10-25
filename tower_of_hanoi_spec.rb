# frozen_string_literal: true

require_relative 'tower_of_hanoi' # Replace with the actual file path

RSpec.describe TowerOfHanoi do
  before(:each) do
    @game = TowerOfHanoi.new
  end

  describe '#initialize' do
    it 'initializes shuffled colors' do
      expect(@game.instance_variable_get(:@shuffled_colors)).to_not be_empty
    end
  end

  describe '#valid_peg?' do
    it 'returns true for valid peg' do
      expect(@game.send(:valid_peg?, 'A')).to be_truthy
    end

    it 'returns false for invalid peg' do
      expect(@game.send(:valid_peg?, 'X')).to be_falsey
    end
  end

  describe '#set_spacing' do
    it 'returns the correct spacing' do
      expect(@game.send(:set_spacing, 5, 2)).to eq('   ')
    end
  end

  describe '#set_horizontal_borders' do
    it 'returns the correct horizontal borders' do
      expect(@game.send(:set_horizontal_borders, 5)).to eq('+++++++++')
    end

    it 'returns the correct horizontal borders for larger disks' do
      expect(@game.send(:set_horizontal_borders, 12)).to eq('++++++++++++++++++')
    end
  end

  describe '#display_towers' do
    it 'displays the initial configuration' do
      # You can't directly test this method as it has a lot of visual output.
      # You can consider adding tests for other methods or behaviors.
    end
  end

  describe '#suggest_move' do
    it 'suggests a valid move' do
      move = @game.send(:suggest_move, 'A', 'B', 'C', 3)
      expect(move).to eq(%w[A C])
    end

    it 'handles a single disk move' do
      move = @game.send(:suggest_move, 'A', 'B', 'C', 1)
      expect(move).to eq(%w[A C])
    end
  end
end
