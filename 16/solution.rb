require 'set'

sections = open('input.txt').read.split("\n\n")

# nearby_seats = Set[]
# nearby_seats_sorted = []
# first = true
# sections[2].split(/[\n,]/).each do |seat|
#   if first
#     first = false
#   else
#     seat = seat.to_i
#     insert_at = nearby_seats_sorted.bsearch_index { |s| s >= seat } || -1
#     nearby_seats_sorted.insert(insert_at, seat)
#     nearby_seats << seat
#   end
# end
# puts nearby_seats_sorted
nearby_tickets = []
sections[2].split("\n").each do |line|
  list = []
  line.split(',').each do |t|
    list << t.to_i
  end
  nearby_tickets << list
end
nearby_tickets.delete_at(0)

info = {}
sections[0].split("\n").each do |line|
  key = line.split(':')[0].strip
  info[key] = []
  ranges_string = line.split(':')[1].strip
  ranges_string.split(" ").each do |range|
    if range.include? "-"
      from = range.split("-")[0].to_i
      to = range.split("-")[1].to_i
      info[key] << [from, to]
    end
  end
end

def out_of_place_value?(ticket, info)
  ticket.each do |value|
    out = true
    info.each do |k, v|
      v.each do |a|
        f = a[0]
        t = a[1]
        if value >= f && value <= t
          out = false
          break
        end
      end
      unless out
        break
      end
    end
    return value if out
  end
  nil
end

error = 0
valid_tickets = []
nearby_tickets.each do |ticket|
  out = out_of_place_value? ticket, info
  if out
    error += out
  else
    valid_tickets << ticket
  end
end

values = info.length
puts values
info_possible = {}
info.each do |k, v|
  info_possible[k] = []
  0.upto(values - 1) do |i|
    info_possible[k] << i
  end
end

valid_tickets.each do |ticket|
  ticket.each_with_index do |ticket_v, i|
    info.each do |k, v|
      could_be = false
      v.each do |a|
        f = a[0]
        t = a[1]
        could_be ||= ticket_v >= f && ticket_v <= t
      end
      unless could_be
        info_possible[k].delete(i)
      end
    end
  end
end
puts info_possible
info_impossible = {}
info_possible.each do |k, v|
  info_impossible[k] = []
  0.upto(values - 1) do |i|
    info_impossible[k] << i unless info_possible[k].include? i
  end
end
puts info_impossible
info_decided = {}
last_length = 0
while !info_decided.length != info.length
  0.upto(info.length - 1) do |try|
    possible = nil
    info_possible.each do |k, v|
      if v.include? try
        if possible
          possible = nil
          break
        else
          possible = k
        end
      end
    end
    if possible
      info_decided[possible] = try
      info_possible.delete possible
      info_possible.each do |k, v|
        info_possible[k].delete try
      end
      break
    end
  end
  if info_decided.length == last_length
    puts 'fuck'
    break
  end
  last_length = info_decided.length
end
puts info_decided
puts info_decided.length

your_ticket = sections[1].split("\n")[1].split(',').map { |s| s.to_i }
v = 1
info_decided.each do |k, value|
  if k.include? 'departure'
    v *= your_ticket[value]
  end
end
puts v

# puts error
