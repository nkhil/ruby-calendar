#!/usr/bin/env ruby

require 'date'

time = Time.new
year = time.year
month = time.month 

day_map = {
  'Su' => 1,
  'Mo' => 2,
  'Tu' => 3,
  'We' => 4,
  'Th' => 5,
  'Fr' => 6,
  'Sa' => 7,
}

def abbreviate_day(day)
  day.slice(0, 2)
end

def days_in_month(month, year)
  Date.new(year, month, -1).day
end

def create_first_week(index)
  first_week = Array.new(7)
  indexArr = (1..index).to_a 
  first_week.each_with_index do |day, i|
    first_week[index - 1] = i + 1
    index += 1
  end
  return first_week
end

def print_week(week_arr)
  week_arr.each do |day|
    if !day then
      print '   '
    elsif day < 10
      print "#{day}  "
    else
      print "#{day} "
    end
  end
  print "\n"
end

def get_remaining_days_of_month(num_of_days_left, days_in_first_week)
  remaining_days_of_month = []
  num_of_days_left.times do |day|
    remaining_days_of_month.push(days_in_first_week + 1)
    days_in_first_week += 1
  end
  return remaining_days_of_month
end

def chunk_remaining_days(remaining_days) 
  remaining_days.each_slice(7).to_a
end

def print_remaining_days(chunked_array)
  chunked_array.each do |chunk|
    print_week(chunk)
  end
end

def get_first_day_of_month(date_string)
  Date.parse(date_string).strftime("%A")
end

def print_header
  time = Time.new
  puts "#{time.strftime("%B %Y")}"
  puts "Su Mo Tu We Th Fr Sa" 
end

def orchestrator(days_this_month, first_day_of_week, day_map)
  print_header()
  month_start_index = day_map[first_day_of_week]
  first_week = create_first_week(month_start_index)
  print_week(first_week)
  num_of_days_left = days_this_month - first_week.compact.length
  days_in_first_week = first_week.compact.length
  remaining_days_of_month = get_remaining_days_of_month(num_of_days_left, days_in_first_week)
  chunked_remaining_days = chunk_remaining_days(remaining_days_of_month)
  print_remaining_days(chunked_remaining_days)
end

day_of_week = abbreviate_day(time.strftime("%A"))
days_this_month = days_in_month(month, year)
first_day_of_month = abbreviate_day(get_first_day_of_month(time.strftime("1 %B %Y")))
orchestrator(days_this_month, first_day_of_month, day_map)
