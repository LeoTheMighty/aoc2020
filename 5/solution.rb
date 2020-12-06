# [top-left, top-right, bottom-left, bottom-right]
require 'set'

class Coordinate
  attr_reader :r, :c
  attr_writer :r, :c

  def initialize(r, c)
    @r = r
    @c = c
  end

  def passport_id
    (@r * 8) + @c
  end

  def draw
    "(r#{@r}, c#{@c})"
  end
end

def av(v1, v2)
  (v1 + v2) / 2
end

class Section
  attr_reader :tl, :tr, :bl, :br
  attr_writer :tl, :tr, :bl, :br

  def initialize(tl, tr, bl, br)
    @tl = tl
    @tr = tr
    @bl = bl
    @br = br
  end

  def front
    @tl.r = av(@tl.r + 1, @bl.r) - 1
    @tr.r = av(@tr.r + 1, @br.r) - 1
  end

  def back
    @bl.r = av @tl.r + 1, @bl.r
    @br.r = av @tr.r + 1, @br.r
  end

  def left
    @br.c = av(@br.c + 1, @bl.c) - 1
    @tr.c = av(@tr.c + 1, @tl.c) - 1
  end

  def right
    @bl.c = av @br.c + 1, @bl.c
    @tl.c = av @tr.c + 1, @tl.c
  end

  def compress
    Coordinate.new(av(@tl.r, @bl.r), av(@br.c, @tl.c))
  end

  def passport_id
    compress.passport_id
  end

  def draw
    "[#{@tl.draw}, #{@tr.draw}, #{@bl.draw}, #{@br.draw}]"
  end
end

def read_passport(section, passport)
  puts section.draw
  passport.each_char do |c|
    case c
    when 'F'
      section.front
    when 'B'
      section.back
    when 'R'
      section.right
    when 'L'
      section.left
    end
    puts section.draw
  end
  puts section.compress.draw
  section.passport_id
end

highest_id = -1

a = Set[]
16.upto(127 * 7 + 6) do |id|
  a << id
end

open('input.txt').each do |line|
  inital_section = Section.new(Coordinate.new(128, 0), Coordinate.new(128, 7), Coordinate.new(0, 0), Coordinate.new(0, 7))
  id = read_passport inital_section, line
  puts "#{line.strip()}: #{id}"
  highest_id = [id, highest_id].max
  a.delete id
end
puts highest_id
puts a



def initial
  Section.new(Coordinate.new(127, 0), Coordinate.new(127, 7), Coordinate.new(0, 0), Coordinate.new(0, 7))
end

# initial_section = initial
# puts read_passport initial_section, 'BFFFBBFRRR'




