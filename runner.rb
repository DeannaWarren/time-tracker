# running code
require_relative 'clock.rb'

clock = Clock.new

puts "Welcome to your time tracker!"

loop do
  puts "I will sleep for a little while and remind you soon"
  sleep clock.minutes(0.25)
  puts "I'm back"
  system("say hello")
  puts "menu : 1 for play, 2 for procrastinating, 3 for work"
  input = gets.chomp
  puts "You said: #{input}"
  break
end