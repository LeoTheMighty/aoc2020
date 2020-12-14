def get_time_depart(estimate, bus_id)
  # bus_id * n >= estimate
  (estimate / bus_id.to_f).ceil * bus_id
end

earliest_time = 0
increment = 1
i = 0
open('input.txt').read.split("\n")[1].split(",").each do |bus_id|
  if bus_id != 'x'
    while (get_time_depart(earliest_time, bus_id.to_i) - earliest_time) - i % bus_id.to_i != 0
      earliest_time += increment
    end
    increment = increment.lcm(bus_id.to_i)
  end
  i += 1
end
puts earliest_time
