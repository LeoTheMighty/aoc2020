#

# end
require 'set'




votes = 0
open('input.txt').read.split("\n\n").each do |group|
  group_letters = Set[('a'..'z').to_a]
  group.split("\n").each do |kid|
    alpha = Set[('a'..'z').to_a]
    letters = Set[kid.split("")]
    puts "#{alpha} - \"#{letters} = #{alpha - letters}"
    not_letters = alpha.difference letters
    puts "#{alpha} - \"#{letters} = #{not_letters}"
    group_letters -= not_letters
  end

  group_letters.reject! { |c| !('a'..'z').to_a.include? c }
  # puts "\"#{group}\" -> #{group_letters}"
  votes += group_letters.length
end

puts votes
