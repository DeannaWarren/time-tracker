# running code
require 'csv'


def results
  puts "this will have the results"
  csv_output = CSV.read("data.csv")
  csv_output.flatten!.shift
  result_hash = {
    play: 0,
    procrastination: 0,
    work: 0,
    count: 0
  }
  csv_output.each do |item|
    case item
    when "play"
      result_hash[:play] += 1
    when "procrastination"
      result_hash[:procrastination] += 1
    when "working"
      result_hash[:work] += 1
    else
      result_hash[:count] += 1
    end
  end
  play_percent = (result_hash[:play].to_f/result_hash[:count].to_f) * 100
  procrastination_percent = (result_hash[:procrastination].to_f/result_hash[:count].to_f) * 100
  work_percent = (result_hash[:work].to_f/result_hash[:count].to_f) * 100
  puts "Play: #{play_percent.round(2)}% \nProcrastination: #{procrastination_percent.round(2)}% \nWork: #{work_percent.round(2)}%"
end

def data_input
  done = false
  until done
    puts "I'm going to go take a nap, check in with you in a few!"
    # sleep 1
    # system("say hello")
    puts "What are you doing?"
    puts "Choices: 1 for PLAY, 2 for PROCRASTINATION, 3 for WORKING, 4 for GO AWAY AND COME BACK LATER, 5 for PLEASE STOP"
    case gets.chomp
    when "1"
      data = "play"
    when "2"
      data = "procrastination"
    when "3"
      data = "working"
    when "4"
      puts "Ok! I won't take any data this time."
    when "5"
      done = true
    else
      puts "that is not a valid response"
    end
    file = File.open("data.csv","a")
    file.write(",#{Time.now},#{data}") if data
    file.close
  end
end

def menu
  done = false
  until done
    puts "What would you like to do?"
    puts "Choices: 1 for Input, 2 for Results, 3 for Quit."
    case gets.chomp
    when "1"
      data_input
    when "2"
      results
    when "3"
      done = true
    else
      puts "That wasn't a valid option, sorry!"
    end
  end
end

#-----------------------------------
# Actual Program
puts "Welcome to your time tracker!"
sleep 0.5

menu

puts "Thank you and Goodbye!!"