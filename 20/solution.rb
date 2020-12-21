def binary_repr(edge_str)
  r = edge_str.chars.map { |c| c == '#' ? '1' : '0' }
  str = r.join('')
  [str.to_i(2), str.reverse.to_i(2)].max
end

tile_strings = open('input.txt').read.split("\n\n")
tiles = {} # id => tile
tile_edges = {} # id => [top, left, bottom, right]
connections = {} # id => [id, id, id, id]
edges = {} # binary_repr => [id, id]
tile_strings.each do |tile|
  id = tile.split("\n")[0].split(" ")[1][0..-2].to_i
  s1 = ''
  s2 = ''
  str = ''
  split = tile.split("\n")[1..]
  split.each_with_index do |line, i|
    s1 << line[0]
    str << "#{line[1..-2]}\n" if i > 0 && i < split.length - 1
    s2 << line[-1]
  end
  tiles[id] = str
  # Make binary number out of
  tile_e = [
    binary_repr(tile.split("\n")[1]), # top
    binary_repr(s1),                  # left
    binary_repr(tile.split("\n")[-1]),# bottom
    binary_repr(s2),                  # right
  ]

  tile_edges[id] = tile_e
  connections[id] = [-1, -1, -1, -1]
  tile_e.each_with_index do |e, i|
    if edges.has_key? e
      connect = edges[e][0]
      connections[id][i] = connect
      j = tile_edges[connect].find_index e
      connections[connect] << id
    else
      edges[e] = []
    end
    edges[e] << id
  end
  # puts "[#{e1.to_s(2)}, #{e2.to_s(2)}, #{e3.to_s(2)}, #{e4.to_s(2)}]"
end

count = 0
mult = 1
corners = []
connections.each do |id, v|
  if v.length == 2
    mult *= id
    count += 1
    corners << id
  end
end
puts count
puts mult

# construct the string image

