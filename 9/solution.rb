require 'set'

def has_sum_in(num, previous_numbers)
  s = Set[]
  previous_numbers.each do |n|
    if s.include? n
      return true
    end
    s << num - n
  end
  false
end

i = 0
previous_numbers = []
length = 25
num = -1
all_numbers = []
open('input.txt').each do |line|
  num = line.to_i
  if i >= length
    # not preamble

    break unless has_sum_in num, previous_numbers
    previous_numbers.pop
  end
  previous_numbers.unshift(num)
  all_numbers << num
  i += 1
end

puts num

def sum_numbers_in_window(all_numbers, window)
  sum = 0
  window[0].upto(window[1]) do |n|
    sum += all_numbers[n]
  end
  sum
end

puts sum_numbers_in_window(all_numbers, [1, 2])

target = num
window = [0, 1]
while (t_sum = sum_numbers_in_window(all_numbers, window)) != target
  if t_sum > target
    # make window smaller
    window[0] += 1
    if window[0] == window[1]
      window[1] += 1
    end
  else
    # make window bigger
    window[1] += 1
  end
end
puts "numbers[#{window[0]}..#{window[1]}]"
puts all_numbers[window[0]]
puts all_numbers[window[1]]
puts all_numbers[window[0]] + all_numbers[window[1]]

def smallest_and_largest_sum(all_numbers, window)
  numbers = all_numbers[window[0]..window[1]]
  numbers.max + numbers.min
end

puts smallest_and_largest_sum(all_numbers, window)
