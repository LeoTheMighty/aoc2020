require 'set'

# possible_contains = {} # ingredient => [contain1, contain2]
possible_ingredients = {} # contains => Set[i1, i2]
food_details = [] # { ingredients: [], contains: [] }
open('input.txt').each do |line|
  parts = line.split(" ")
  ingredients = []
  contains = []
  at_contains = false
  parts.each do |p|
    if !at_contains && p[0] == '('
      at_contains = true
      next
    end
    if at_contains
      contains << p[0..-2]
    else
      ingredients << p
    end
  end
  food_details << { ingredients: ingredients, contains: contains }
  ingredients_set = Set.new(ingredients)
  contains.each do |c|
    possible_ingredients[c] = ingredients_set unless possible_ingredients.include? c
    possible_ingredients[c] = ingredients_set & possible_ingredients[c]
  end
end

repeat = true
while repeat
  repeat = false
  figured_out = Set[]
  possible_ingredients.each do |k, v|
    if v.length == 0
      puts "PROBLEM"
    elsif v.length == 1
      # figured out
      figured_out << v.to_a[0]
    end
  end
  puts figured_out
  possible_ingredients.each do |k, v|
    if v.length != 1
      possible_ingredients[k] -= figured_out
      if possible_ingredients[k] != v
        repeat = true
      end
    end
  end
  puts possible_ingredients
end

possible = Set[]
danger = {}
possible_ingredients.each do |k, v|
  possible += v.to_a
  if v.length == 1
    danger[k] = v.to_a[0]
  end
end

impossible_count = 0
food_details.each do |food|
  imp_i = food[:ingredients].filter { |i| !possible.include?(i) }
  impossible_count += imp_i.length
end
puts impossible_count
danger.keys.sort.each { |k| print "#{danger[k]}," }
$stdout.flush
