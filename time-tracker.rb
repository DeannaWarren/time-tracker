class TimeTracker
  require 'csv'
  require 'date'

  def initialize
  end

  def menu
    puts "Welcome to your time tracker!"
    sleep 0.5
    done = false
    until done
      puts "What would you like to do?"
      puts "Choices: 1 for Input, 2 for Results, 3 for Quit."
      case gets.chomp
      when "1"
        self.data_input
      when "2"
        self.results
      when "3" || "exit"
        done = true
      else
        puts "That wasn't a valid option, sorry!"
      end
    end
    puts "Thank you and Goodbye!!"
  end

  def data_input
    done = false
    until done
      puts "I'm going to go take a nap, check in with you in a few!"
      sleep (5 * 60)
      system("say hello")
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
      when "5" || "exit"
        done = true
      else
        puts "that is not a valid response"
      end
      if data
        file = File.open("data.csv","a")
        file.write(",#{Date.today},#{data}")
        file.close
      end
    end
  end

  def results
    puts "this will have the results"
    csv_output = CSV.read("data.csv")
    if csv_output[0] == nil
      puts "There are no results!"
    else
      csv_output.flatten!
      csv_output.shift
      result_hash = {
        today: {
          play: 0,
          procrastination: 0,
          work: 0,
          count: 0
        },
        play: 0,
        procrastination: 0,
        work: 0,
        count: 0
      }
      csv_output.each_with_index do |value, index|
        case value
        when "play"
          result_hash[:play] += 1
        when "procrastination"
          result_hash[:procrastination] += 1
        when "working"
          result_hash[:work] += 1
        else
          result_hash[:count] += 1
          if Date.parse(value) == Date.today
            result_hash[:today][:count] += 1
            case csv_output[index+1]
            when "play"
              result_hash[:today][:play] += 1
            when "procrastination"
              result_hash[:today][:procrastination] += 1
            when "working"
              result_hash[:today][:work] += 1
            else
              puts "There seems to be an error in your CSV file"
            end
          end
        end
      end
      play_percent = (result_hash[:play].to_f/result_hash[:count].to_f) * 100
      procrastination_percent = (result_hash[:procrastination].to_f/result_hash[:count].to_f) * 100
      work_percent = (result_hash[:work].to_f/result_hash[:count].to_f) * 100
      play_change = ((result_hash[:today][:play].to_f/result_hash[:today][:count].to_f) * 100) - play_percent
      procrastination_change = ((result_hash[:today][:procrastination].to_f/result_hash[:today][:count].to_f) * 100) - procrastination_percent
      work_change = ((result_hash[:today][:work].to_f/result_hash[:today][:count].to_f) * 100) - work_percent
      puts "Play: #{play_percent.round(2)}%  (#{play_change.round(2)}% change today)\nProcrastination: #{procrastination_percent.round(2)}%  (#{procrastination_change.round(2)}% change today) \nWork: #{work_percent.round(2)}% (#{work_change.round(2)}% change today)"
    end
  end

end
