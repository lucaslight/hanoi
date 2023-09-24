require_relative 'tower_of_hanoi'
require_relative 'controller'

puts "Welcome to Tower of Hanoi!"
puts "Enter the number of disks: "
disks = gets.chomp.to_i

controller = Controller.new(disks)
controller.play
