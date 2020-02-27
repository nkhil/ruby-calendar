require 'date'

time = Time.new
# puts time.strftime("%B %Y")
year = time.month
month = time.year 

# puts year.to_s
# puts month.to_s

def days_in_month(month, year)
  Date.new(year, month, -1).day
end

puts days_in_month(year, month);