

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
  (r - 1).upto(r + 1) do |rr|
    (c - 1).upto(c + 1) do |cc|
      if rr != r && cc != c && get_val(rr, cc) == '#'
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
    end
  elsif seat == '#'
    if how_many_occupied_around(r, c) >= 4
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

