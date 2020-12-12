# [adj, color, "bags", "contain", [num ]]

require 'set'

class Color
  attr_reader :name, :can_hold, :can_be_held_by

  def initialize(name)
    @name = name
    @can_hold = {}
    @can_be_held_by = []
  end

  def add_children(name, count)
    @can_hold[name] = count
  end

  def add_parent(name)
    @can_be_held_by << name
  end
end

$all_colors = {}

def get_color(name)
  $all_colors[name] = Color.new(name) unless $all_colors.key? name
  $all_colors[name]
end

open('input.txt').each do |line|
  words = line.split(" ")
  color = get_color(words[0..1].join(" "))
  if words[4] != 'no'
    repeat_words = words[4..]
    0.upto((repeat_words.length / 4) - 1) do |i|
      a = (i * 4) + 1
      b = (i * 4) + 2
      child_color = get_color(repeat_words[a..b].join(" "))
      child_count = repeat_words[(i * 4)].to_i
      color.add_children(child_color.name, child_count)
      child_color.add_parent(color.name)
    end
  end
end

pointer = get_color("shiny gold")
to_visit = pointer.can_be_held_by.clone
visited = []
can_hold = Set[]
while to_visit.any?
  color_name = to_visit.pop()
  color = get_color(color_name)
  visited << color_name
  to_visit += (color.can_be_held_by - visited)
  can_hold << color_name
end
puts can_hold.length

def needs_to_hold_except(color, exempt_name)
  full_count = 0
  color.can_hold.each do |child_color, count|
    if child_color != exempt_name
      c = needs_to_hold_except(get_color(child_color), exempt_name)
      full_count += (count * c)
    end
  end
  full_count + 1
end

puts needs_to_hold_except(get_color("shiny gold"), 'shiny gold')




# {
#   "vibrant plum" => {
#     "faded_blue"
#   }
# }


open('input.txt').read.split("\n\n")
