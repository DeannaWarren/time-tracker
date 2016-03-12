# running code
require_relative 'clock.rb'

clock = Clock.new

puts "Welcome to your time tracker!"
sleep 0.25
puts "What would you like to do?"
puts "Choices: 1 for Input, 2 for Quit."
result = gets.chomp
case result
when '1'
  data_input
when '2'
end

def data_input
  loop do
    break
    puts "I'm going to go take a nap, check in with you in a few minutes!"
    sleep 5
    system("say hello")
    puts "What are you doing?"
    puts "Choices: 1 for PLAY, 2 for PROCRASTINATION, 3 for WORKING, 4 for GO AWAY AND COME BACK LATER, 5 for PLEASE STOP"
    result = gets.chomp
    file = File.open("data.csv","a")
    case result
    when "1"
      data = "play"
    when "2"
      data = "procrastination"
    when "3"
      data = "working"
    when "5"
      break
    end
    file.write(",#{Time.now},#{data}") if data
    file.close
  end
end


puts "Thank you!!"