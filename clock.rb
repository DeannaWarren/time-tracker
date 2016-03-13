# objects that hold variables for time manipulation
class Clock

  def initialize
    # time structures such as minutes and weeks are listed here
    @minute = 60
  end

  def minutes(num)
    @minute * num
  end

end