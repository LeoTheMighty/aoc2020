
x = 0
y = 0
wx = 10
wy = 1
angle = 0
open('input.txt').each do |line|
  d = line[0]
  amount = line[1..].to_i
  case d
  when 'N'
    wy += amount
  when 'W'
    wx -= amount
  when 'S'
    wy -= amount
  when 'E'
    wx += amount
  when 'L'
    angle = Math.atan2(wy, wx) * 180 / Math::PI
    angle += amount
    wl = Math.sqrt(wx * wx + wy * wy)
    wx = wl * Math.cos(angle * Math::PI / 180)
    wy = wl * Math.sin(angle * Math::PI / 180)
  when 'R'
    angle = Math.atan2(wy, wx) * 180 / Math::PI
    angle -= amount
    wl = Math.sqrt(wx * wx + wy * wy)
    wx = wl * Math.cos(angle * Math::PI / 180)
    wy = wl * Math.sin(angle * Math::PI / 180)
  when 'F'
    x += (amount * wx)
    y += (amount * wy)
  else
    puts 'wtf'
  end
  puts "[#{line[0..-2]}] ship(x: #{x}, y: #{y}) waypoint(x: #{wx}, y: #{wy}, a: #{angle})"
end

puts x.abs + y.abs
