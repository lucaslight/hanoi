# frozen_string_literal: true

require 'colorize'

class TowerOfHanoi
  def initialize
    @colors = %i[
      red green yellow blue magenta cyan white
      light_black light_red light_green light_yellow light_blue
      light_magenta light_cyan light_white
    ]
    @destination_peg = 'C'
    @towers = { 'A' => [], 'B' => [], 'C' => [] }
    @shuffled_colors = @colors.shuffle
  end

  def play
    puts 'Welcome to the Tower of Hanoi Game!'
    num_disks = get_user_input('Enter the number of disks: ').to_i

    game_setup(num_disks)
    puts 'The initial configuration of the Tower of Hanoi is complete.'

    display_towers(num_disks)

    loop do
      user_input = get_user_input("Enter the move (e.g., 'ab' or 'ca'), 'h' for hint or 'q' to quit: ").upcase
      break if quit?(user_input)

      if hint?(user_input)
        hint = suggest_move()
        if hint
          puts "Hint: Move from peg #{hint[0]} to peg #{hint[1]}"
        else
          puts 'Hint: No legal move available.'
        end
        next
      end

      if user_input.length == 2
        from_peg = user_input[0]
        to_peg = user_input[1]

        if valid_peg?(from_peg) && valid_peg?(to_peg)
          if @towers[from_peg].empty?
            puts 'Invalid move. Source peg is empty.'
          elsif !@towers[to_peg].empty? && @towers[to_peg].last < @towers[from_peg].last
            puts 'Invalid move. Cannot place a larger disk on a smaller one.'
          else
            @towers[to_peg] << @towers[from_peg].pop
            display_towers(num_disks)
            winning_message unless !winning_turn?(num_disks)
          end
        else
          puts 'Invalid source or target peg. Please enter A, B, or C.'
        end
      else
        puts "Invalid input format. Please enter a move like 'ab' or 'ca'."
      end
    end
    # setup_play_again if play_again? unless !winning_turn?(num_disks)
    setup_play_again if play_again?
  end

  private

  def hint?(user_input)
    user_input == 'H'
  end

  def quit?(user_input)
    user_input == 'Q'
  end

  def play_again?
    play_again = get_user_input('Do you want to play again? (Y/N): ')
    play_again == 'Y'
    
  end
  def setup_play_again
    @towers = { 'A' => [], 'B' => [], 'C' => [] }
    play
  end

  def game_setup(disks)
    if disks <= 0
      puts 'Please enter a positive number of disks.'
      play
    elsif disks > 15
      puts 'Please enter a lower number of disks.'
      play
    end
    @towers['A'] = (1..disks).to_a.reverse
  end

  def move_disk(source, target)
    puts "Move a disk from #{source} to #{target}"
  end

  def valid_peg?(peg)
    %w[A B C].include?(peg)
  end

  def winning_turn?(disks)
    @towers[@destination_peg].length == disks
      # puts "Congratulations! You've completed the Tower of Hanoi game."
  end

  def set_spacing(disks, int = 0)
    ' ' * (disks - int)
  end

  def set_horizontal_borders(disks)
    "+#{'-' * (disks > 9 ? disks * 2 : (disks * 2) - 1)}+"
  end

  def display_towers(disks)
    system('clear') || system('cls') # Clear screen
    extra_space = disks > 9 ? ' ' : ''
    disks.downto(1) do |level|
      @towers.each do |_, peg|
        disk = peg[level - 1] || 0
        if disk.zero?
          print "#{(' ' * disks) + extra_space}|#{' ' * disks}"
        else
          color = @shuffled_colors[disk - 1]
          colored_half_disc = '*'.colorize(color)
          print ' ' * (disks - disk)
          print colored_half_disc * disk
          print disks > 9 && disk < 10 ? "0#{disk}" : disk
          print colored_half_disc * disk
          print ' ' * (disks - disk)
        end
        print '  '
      end
      puts
    end

    horizontal_borders = set_horizontal_borders(disks)
    box_spacing = set_spacing(disks, 1)

    puts "#{horizontal_borders}  #{horizontal_borders}  #{horizontal_borders}"
    puts "|#{box_spacing + extra_space}A#{box_spacing}|  |#{box_spacing + extra_space}B#{box_spacing}|  |#{box_spacing + extra_space}C#{box_spacing}|"
    puts "#{horizontal_borders}  #{horizontal_borders}  #{horizontal_borders}"
  end

  def winning_message
    message = "Congratulations! You've completed the Tower of Hanoi game."
    colors = %i[red yellow green blue magenta cyan white]

    10.times do
      system('clear') || system('cls')
      rainbow_message = message.colorize(colors.sample)
      puts rainbow_message
      sleep(0.3)
    end
  end

  def get_user_input(prompt)
    print prompt
    gets.chomp.upcase
  end

  def suggest_move(source_peg = 'A', auxiliary_peg = 'B', target_peg = 'C', num_disks = @towers['A'].length)
    return source_peg, target_peg if num_disks == 1

    move = suggest_move(source_peg, target_peg, auxiliary_peg, num_disks - 1)
    return move if move

    move_disk(source_peg, target_peg)

    suggest_move(auxiliary_peg, source_peg, target_peg, num_disks - 1)
  end
end

# Start the game only if this script is executed directly
TowerOfHanoi.new.play if __FILE__ == $PROGRAM_NAME
