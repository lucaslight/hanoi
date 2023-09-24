class Controller
  def initialize(disks)
    @game = TowerOfHanoi.new(disks)
  end

  def play
    until @game.won?
      @game.render
      puts "Enter your move: "
      source = gets.chomp.upcase

      case source
      when 'H'
        puts "Hint: Try to move a smaller disk onto a larger one."
        next
      when 'Q'
        puts "Quitting the game."
        return
      when 'A', 'B', 'C'
        source = source
      else
        puts "Invalid input. Please enter A, B, C, H, or Q."
        next
      end

      puts "Enter the tower to move to: "
      destination = gets.chomp.upcase

      if ['A', 'B', 'C'].include?(destination)
        if @game.move(source, destination)
          puts "Move from Tower #{source} to Tower #{destination} successful!"
        else
          puts "Invalid move. Please try again."
        end
      elsif destination == 'Q'
        puts "Quitting the game."
        return
      else
        puts "Invalid input. Please enter A, B, C, or Q."
      end
    end

    @game.render
    puts "Congratulations! You've won the game in #{@game_moves} moves."
  end
end
