require 'set'

target = 2020
h = {}
s = Set[]

open('input.txt').each do |line|
  v1 = line.to_i
  if h.has_key?(v1)
    puts v1 * h[v1][0] * h[v1][1]
  else
    s.each do |v2|
      h[target - v1 - v2] = [v1, v2]
    end
    s << v1
  end
end

