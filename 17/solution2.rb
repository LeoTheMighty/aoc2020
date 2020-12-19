# w, z, r, c
require 'set'

# space =
# space = { w: { z: { r: { c: true } } } }
def is_active?(space, w, z, r, c)
  space.[](w)&.[](z)&.[](r)&.[](c) || false
end

def set_active(space, w, z, r, c, v)
  unless space[w]
    space[w] = {}
  end
  unless space[w][z]
    space[w][z] = {}
  end
  unless space[w][z][r]
    space[w][z][r] = {}
  end
  space[w][z][r][c] = v
end

def activate(space, w, z, r, c)
  set_active space, w, z, r, c, true
end

def deactivate(space, w, z, r, c)
  if is_active?(space, w, z, r, c)
    space[w][z][r].delete c
    space[w][z].delete(r) if space[w][z][r].empty?
    space[w].delete z if space[w][z].empty?
    space.delete w if space[w].empty?
  end
end

def count_active(space)
  count = 0
  space.each do |w, v1|
    v1.each do |z, v2|
      v2.each do |r, v3|
        v3.each do |c, v|
          count += 1 if v
        end
      end
    end
  end
  count
end

def construct_space(flat_string)
  space = { 0 => {} }
  flat_string.split("\n").each_with_index do |row, r|
    row.strip.split("").each_with_index do |s, c|
      if s == '#'
        activate space, 0, 0, r, c
      end
    end
  end
  space
end

def deep_copy(space)
  copy = {}
  space.each do |w, v1|
    v1.each do |z, v2|
      v2.each do |r, v3|
        v3.each do |c, v|
          set_active(copy, w, z, r, c, v)
        end
      end
    end
  end
  copy
end

def get_number_active_around(space, w, z, r, c)
  count = 0
  (w - 1).upto(w + 1) do |w1|
    (z - 1).upto(z + 1) do |z1|
      (r - 1).upto(r + 1) do |r1|
        (c - 1).upto(c + 1) do |c1|
          if z1 != z || r1 != r || c1 != c || w1 != w
            count += 1 if is_active?(space, w1, z1, r1, c1)
          end
        end
      end
    end
  end
  count
end

def get_inactive_around(space, w, z, r, c)
  inactive = []
  (w - 1).upto(w + 1) do |w1|
    (z - 1).upto(z + 1) do |z1|
      (r - 1).upto(r + 1) do |r1|
        (c - 1).upto(c + 1) do |c1|
          if z1 != z || r1 != r || c1 != c || w1 != w
            inactive << [w1, z1, r1, c1] unless is_active?(space, w1, z1, r1, c1)
          end
        end
      end
    end
  end
  inactive
end

def get_next_space(space)
  next_space = deep_copy space
  inactive_to_check = Set[] # << [w, z, r, c]
  space.each do |w, v1|
    v1.each do |z, v2|
      v2.each do |r, v3|
        v3.each do |c, v|
          if v
            # check all around it (this is active)
            a = get_number_active_around(space, w, z, r, c)
            deactivate(next_space, w, z, r, c) if a != 2 && a != 3
            inactive_to_check |= get_inactive_around(space, w, z, r, c)
          end
        end
      end
    end
  end
  inactive_to_check.each do |m|
    w = m[0]
    z = m[1]
    r = m[2]
    c = m[3]
    a = get_number_active_around(space, w, z, r, c)
    activate(next_space, w, z, r, c) if a == 3
  end
  next_space
end

def get_dimension(plate)
  max = plate.keys.max
  plate.each do |k, v|
    max = [max, v.keys.max].max
  end
  max
end

# def print_space(space)
#   dimension = -1
#   space.each do |k, v|
#     dimension = [dimension, get_dimension(v)].max
#   end
#   space.keys.sort.each do |z|
#     puts "z = #{z}"
#     0.upto(dimension) do |r|
#       0.upto(dimension) do |c|
#
#         if is_active?(space, z, r, c)
#           print '#'
#         else
#           print '.'
#         end
#       end
#       print "\n"
#     end
#     print "\n"
#   end
#   $stdout.flush
# end

space = construct_space open('input.txt').read
finish = 6
cycle = 0
while cycle != finish
  puts "CYCLE #{cycle}"
  # print_space space
  space = get_next_space space
  cycle += 1
end
puts "FINISH"
# print_space space
puts count_active space
