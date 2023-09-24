class TowerOfHanoi
  def initialize(disks)
    @towers = { 'A' => [], 'B' => [], 'C' => [] }
    @disks = disks
    @moves = 0
    setup_game
  end

  def setup_game
    @towers['A'] = (1..@disks).to_a.reverse
  end

  def valid_move?(from, to)
    return false if @towers[from].empty?
    return true if @towers[to].empty?
    @towers[from].last < @towers[to].last
  end

  def move(from, to)
    if valid_move?(from, to)
      disk = @towers[from].pop
      @towers[to].push(disk)
      @moves += 1
      true
    else
      false
    end
  end

  def won?
    @towers['B'].length == @disks || @towers['C'].length == @disks
  end
  # def render
  #   puts "Tower of Hanoi"

  #   max_height = @towers['A'].size
  #   initial_height = @disks

  #   initial_height.downto(1) do |level|
  #     @towers.each do |tower, disks|
  #       disk = disks[level - 1] || 0
  #       disk_representation = '*' * (disk - 1) + '*' + '|' + '*' * (disk - 1)

  #       if level > max_height
  #         print " " * (@disks * 2 + 1)
  #       else
  #         print disk_representation.center(@disks * 2 + 1)
  #       end

  #       print "  "
  #     end
  #     puts
  #   end

  #   puts "a - Left Tower | s - Middle Tower | d - Right Tower | h - Hint | q - Quit"
  # end


  def render
    puts "Tower of Hanoi"

    @disks.downto(1) do |level|
      @towers.each do |tower, disks|
        disk = disks[level - 1] || 0
        # require 'pry'; binding.pry

        disk_size = disk * 2 - 1

        if disk == 0
          # print " " * (@disks - 1) + "|" + " " * (@disks - 1)
          print (" " * @disks) + "|" + (" " * @disks)
        else
          # print " " * ((@disks - disk) / 2)
          print " " * (@disks)
          print '*' * disk_size
          print '|'
          print '*' * disk_size
          print " " * (@disks - disk)
          # print " " * ((@disks - disk) / 2)
        end

        print "  "
      end
      puts
    end

    puts "A - Left Tower | B - Middle Tower | C - Right Tower | h - Hint | q - Quit"
  end




end