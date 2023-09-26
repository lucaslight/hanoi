class Controller
  def initialize(disks)
    @game = TowerOfHanoi.new(disks)
  end

  def play
    until @game.won?
      @game.render
      puts "Enter your tower to move from: "
      source = gets.chomp.upcase

      case source
        when 'H'
          puts "Hint: Try to move a smaller disk onto a larger one."
          next
        when 'Q'
          puts "Quitting the game."
          return
        when 'A'
          source = 'A'
        when 'S', 'B'
          source = 'B'
        when 'D', 'C'
          source = 'C'
        else
          puts "Invalid input. Please enter A, S, D, or A, B, C to play or Q to quit."
          next
      end

      puts "Enter the tower to move to: "
      destination = gets.chomp.upcase

      case destination
        when 'H'
          puts "Hint: Try to move a smaller disk onto a larger one."
          next
        when 'Q'
          puts "Quitting the game."
          return
        when 'A'
          destination = 'A'
        when 'S', 'B'
          destination = 'B'
        when 'D', 'C'
          destination = 'C'
        else
          puts "Invalid input. Please enter A, S, D, or A, B, C to play or Q to quit."
          next
      end

      if @game.move(source, destination)
        puts "Move from Tower #{source} to Tower #{destination} successful!"
      else
        puts "Invalid move. Please try again."
      end
    end

    @game.render
    puts "Congratulations! You've won the game in #{@game_moves} moves."
  end
end
