require 'set'

s = Set[]
target = 2020

open('input.txt').each do |line|
  v = line.to_i
  if s.include?(v)
    puts v * (target - v)
    break
  else
    s << target - v
  end
end

