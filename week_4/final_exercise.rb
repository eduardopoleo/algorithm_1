# Build the graph using hash and arrays
require 'pry'

time1 = Time.now

file = File.open('data_set.txt', 'r')
lines = file.readlines
file.close
puts ENV['RUBY_THREAD_VM_STACK_SIZE']
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


def topological_sort
	$vertices.each do |vertex_id, info|
		vertex = $vertices[vertex_id]
		if !vertex[:seen]
			dfs_visit_sort(vertex, vertex_id)
		end
	end
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

# Pass vertex_id so that I do not have to repeat the look up
def dfs_visit_sort(vertex, vertex_id)
	mark_seen(vertex)

	vertex[:edges].each do |e|
		edge = $vertices[e]

		if !edge[:seen]
			dfs_visit_sort(edge, e)
		end
	end

	$sort << vertex_id
end


topological_sort

while !$sort.empty? do
	vertex_id = $sort.pop
	vertex = $vertices_reverse[vertex_id]

	if !vertex[:seen]
		dfs_visit(vertex, vertex_id)
		$all_scc << $scc
		$scc = []
	end
end

p $all_scc.map(&:size).sort


time2 = Time.now

benchmark = (time2 - time1)/60

p benchmark

