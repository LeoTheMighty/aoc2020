

def get_time_depart(estimate, bus_id)
  # bus_id * n >= estimate
  (estimate / bus_id.to_f).ceil * bus_id
end

stuff = open('input.txt').read
estimate = stuff.split("\n")[0].to_i
earliest_id = -1
earliest_depart = 9999999999
stuff.split("\n")[1].split(",").each do |bus_id|
  next if bus_id == 'x'
  depart = get_time_depart estimate, bus_id.to_i
  if earliest_depart > depart
    earliest_depart = depart
    earliest_id = bus_id.to_i
  end
end
puts earliest_id * (earliest_depart - estimate)

def get_new_timestamp(current, buses_order)
  index = current
  while true
    # test each buses
    earliest = index + buses_order[0]



    index += 1
  end
end

buses_order = []
sorted_buses = [] # {id:, i:, n: 0}

earliest_time = 0
increment = 1
stuff.split("\n")[1].split(",").each do |bus_id|
  i = buses_order.length
  id = (bus_id != 'x' ? bus_id.to_i : -1)
  buses_order << id
  if id != -1
    insert_at = sorted_buses.bsearch_index { |b| b[:id] <= bus_id.to_i } || -1
    sorted_buses.insert(insert_at, {id: id, i: i, n: 0})

    # do the thing
    while true
      remainder = get_time_depart(earliest_time, bus_id.to_i) - earliest_time
      if remainder - i % bus_id.to_i == 0
        break
      else
        earliest_time += increment
      end
    end

    increment = increment.lcm(bus_id.to_i)
  end
end

puts sorted_buses
puts earliest_time

def get_first_time(b)
  b[:id] * b[:n] - b[:i]
end

b0 = sorted_buses[0]
found = false
until found
  prev_b = b0
  found = true
  sorted_buses.each do |b|
    id = b[:id]
    i = b[:i]
    if (get_first_time(prev_b) + i) % id != 0
      found = false
      break
    end
    b[:n] = (get_first_time(prev_b) + i) / id
    prev_b = b
  end
  b0[:n] += sorted_buses[1][:id] unless found
end

puts get_first_time(b0)

# first_correct = -1
# index_to_check = 0
# current_time = 0
# while index_to_check != first_correct
#   check_id = buses_order[index_to_check]
#   if check_id != -1
#     check if it's correct
    # check_depart = get_time_depart(current_time, check_id)
    # if current_time != check_depart - index_to_check
    #   current_time = check_depart - index_to_check
    #   first_correct = index_to_check
    # end
    # now the current time is correct for index_to_check
  # end
  #
  # check the next index
  # index_to_check = (index_to_check + 1) % buses_order.length
# end
#
# puts current_time
