# Build the graph using hash and arrays
require 'pry'

time1 = Time.now

file = File.open('test_data_set7.txt', 'r')
lines = file.readlines
file.close

$vertices = { }
$vertices_reverse = { }
$sort = []
$scc = []
$all_scc = []

lines.each do |l|
  l.chomp!
  line = l.gsub("\n", "").split(" ")

  # creates vertex that will hold the edge
  vertex = $vertices[line[0]]
  vertex ? vertex[:edges] << line[1] : $vertices[line[0]] = { seen: false, edges: [line[1]] }

  # creates the edge node

  edge = $vertices[line[1]]
  $vertices[line[1]] = { seen: false, edges: [] } unless edge
end	


$vertices.each do |vertex_id, info|
	vertex = $vertices_reverse[vertex_id]
  $vertices_reverse[vertex_id] = { seen: false, edges: [] } unless vertex

	info[:edges].each do |edge|
		reverse_vertex = $vertices_reverse[edge]

		if reverse_vertex
			reverse_vertex[:edges] << vertex_id
		else
			$vertices_reverse[edge] = { seen: false, edges: [vertex_id] }
		end
	end
end

def mark_seen(vertex)
	vertex[:seen] = true
end

# more than topological sorting is about sorting the edges
# based on their finishing times. 
# An edge is considered finsihed when we have found everything reachable from it!
# An then we stack them in that order
def topological_sort
	$vertices.each do |vertex_id, info|
		vertex = $vertices[vertex_id]
		if !vertex[:seen]
			dfs_visit_sort(vertex, vertex_id)
		end
	end
end

def dfs_visit_sort(vertex, vertex_id)
	mark_seen(vertex)

	vertex[:edges].each do |e|
		edge = $vertices[e]

		if !edge[:seen]
			dfs_visit_sort(edge, e)
		end
	end
# last element gets added to the sort first
	$sort << vertex_id
end

def dfs_visit(vertex, vertex_id)
	mark_seen(vertex)

	$scc << vertex_id

	vertex[:edges].each do |e|
		edge = $vertices_reverse[e]
		if !edge[:seen]
			dfs_visit(edge, e)
		end
	end
end

topological_sort

$finish_time2 = $sort.map(&:to_i).sort

while !$sort.empty? do
	vertex_id = $sort.pop
	vertex = $vertices_reverse[vertex_id]

	if !vertex[:seen]
		dfs_visit(vertex, vertex_id)
		$all_scc << $scc
		$scc = []
	end
end

# p $all_scc.map(&:size).sort
# p $all_scc.map(&:size).sort.slice(-5..-1).reverse

# p $sort

# time2 = Time.now

# benchmark = (time2 - time1)/60

# p benchmark

