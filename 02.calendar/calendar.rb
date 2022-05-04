require "date"
require "optparse"

def calender(year, month)
  firstday = Date.new( year, month, 1)
  lastday = Date.new( year, month, -1)
  first_wday = firstday.wday
  lastday_date = lastday.day

  puts firstday.strftime("%m月 %Y年").center(20)
  puts "日 月 火 水 木 金 土"
  first_wday.times { print(" ") }
  days = (1..lastday_date).map{ |n| n.to_s.rjust(2)}
  days = Array.new(first_wday, ' ').concat(days).each_slice(7)
  days.each {|week| puts week.join(' ') }
  print("\n")
end

def main
  today = Date.today
  options = ARGV.getopts("y:", "m:")
  year = 
    if options["y"] 
      options["y"].to_i 
    else
      today.year
    end
  month = 
    if options["m"]
      options["m"].to_i 
    else
      today.month
    end
  calender(year, month)
end

main
