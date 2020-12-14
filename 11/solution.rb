
$seats = []
open('input.txt').each do |line|
  seats_row = []
  line.strip().each_char do |c|
    seats_row << c
  end
  $seats << seats_row
end

def print_seats
  $seats.each do |row|
    row.each do |seat|
      print seat
    end
    print "\n"
  end
  $stdout.flush
end

def get_val(r, c)
  return nil if r < 0 || c < 0 || r >= $seats.length || r >= $seats.length
  $seats[r][c]
end

def how_many_occupied_around(r, c)
  count = 0
  -1.upto(1) do |rr|
    -1.upto(1) do |cc|
      next if (rr == 0 && cc == 0)
      # vector = [rr, cc]
      val = nil
      pos = 1
      while true
        val = get_val(r + pos * rr, c + pos * cc)
        if val != '.'
          break
        end
        pos += 1
      end
      if val == '#'
        count += 1
      end
    end
  end
  count
end

def next_state(r, c)
  seat = $seats[r][c]
  if seat == 'L'
    if how_many_occupied_around(r, c) == 0
      return '#'
    else
      return 'L'
    end
  elsif seat == '#'
    if how_many_occupied_around(r, c) >= 5
      return 'L'
    else
      return '#'
    end
  else
    '.'
  end
end

def get_next_seats
  next_seats = []
  $seats.each_with_index do |row, r|
    next_seat_row = []
    row.each_with_index do |seat, c|
      # if c == 0 && r == 8
      #   puts 'yeet'
      # end
      next_seat_row << next_state(r, c)
    end
    next_seats << next_seat_row
  end
  next_seats
end

def changed(seats, next_seats)
  seats.each_with_index do |row, r|
    row.each_with_index do |seat, c|
      if seat != next_seats[r][c]
        return true
      end
    end
  end
  false
end

def how_many_occupied
  count = 0
  $seats.each do |row|
    row.each do |seat|
      count += 1 if seat == '#'
    end
  end
  count
end

while true
  puts
  print_seats
  next_seats = get_next_seats
  unless changed $seats, next_seats
    break
  end
  $seats = next_seats
end

puts how_many_occupied

## -------- other way
#

=begin
def val(map, r, c)
  rows = map.split("\n")
  return nil if r < 0 || c < 0 || r >= rows.length || c >= rows[0].length
  map.split("\n")[r][c]
end

def set_val(map, v, r, c)
  rows = map.split("\n")
  raise(Exception, "Out of bounds(r: #{r}, c: #{c})") if r >= rows.length || c >= rows[0].length
  map[r * (map.split("\n")[0].length + 1) + c] = v
end

def through_map(map, &block)
  map.split("\n").each_with_index do |row, r|
    row.split("").each_with_index do |v, c|
      block.call v, r, c
    end
  end
end

def next_value(map, v, r, c)
  count = 0
  (r - 1).upto(r + 1) do |rr|
    (c - 1).upto(c + 1) do |cc|
      count += 1 if (rr != r || cc != r) && val(map, rr, cc) == '#'
    end
  end
  if v == 'L'
    if count == 0
      return '#'
    else
      return 'L'
    end
  elsif v == '#'
    if count >= 4
      return 'L'
    else
      return '#'
    end
  else
    '.'
  end
end

def get_next_iteration(map)
  next_map = map.clone
  map.split("\n").each_with_index do |row, r|
    row.split("").each_with_index do |v, c|
      set_val(next_map, next_value(map, v, r, c), r, c)
    end
  end
  next_map
end

map = IO.read('input.txt')

# p_r = ''
# through_map(map) do |v, r, c|
#   if p_r != r
#     print "\n"
#   end
#   print v
#   p_r = r
# end
# $stdout.flush

puts val(map, 92, 1)
set_val(map, 'x', 92, 1)
puts val(map, 92, 1)

puts get_next_iteration(map)

=end
