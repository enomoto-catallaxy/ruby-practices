require "date"
require "optparse"

def calender(year, month)
	firstday = Date.new( year, month, 1)
	lastday = Date.new( year, month, -1)
	first_wday = firstday.wday
	lastday_date = lastday.day

	puts firstday.strftime("%m月 %Y年").center(20)
	puts "日 月 火 水 木 金 土"
	wday = firstday.wday
	wday.times do
		printf(" ")
	end

	days = (1..lastday_date).map{ |n| n.to_s.rjust(2)}
	days = Array.new(first_wday, ' ').push(days).flatten.each_slice(7).to_a
	days.each do |week|
		puts week.join(' ')
	end
	printf("\n")
end

def main
	today = Date.today
	options = ARGV.getopts("y:", "m:")
	if options["y"] 
		year = options["y"].to_i 
	else
		year = today.year
	end
	if options["m"]
		month = options["m"].to_i 
	else
		month = today.month
	end
	calender(year, month)
end

main
