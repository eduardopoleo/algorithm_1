# Build the graph using hash and arrays
require 'pry'

time1 = Time.now

file = File.open('data_set.txt', 'r')
lines = file.readlines
file.close

vertices = { }
count = 0

lines.each do |l|
  l.chomp!
  line = l.gsub("\n", "").split(" ")

  vertex = vertices[line[0]]
  vertex ? vertex[:edges] << line[1] : vertices[line[0]] = { seen: false, edges: [line[1]] }

	# count += 1
end	

vertices_reverse = { }

count = 0
vertices.each do |vertex_id, info|
	info[:edges].each do |edge|
		reverse_vertex = vertices_reverse[edge]

		if reverse_vertex
			reverse_vertex[:edges] << vertex_id
		else
			vertices_reverse[edge] = { seen: false, edges: [vertex_id] }
		end
	end
end



# Build a visible graph

# seen = {
# 	1: false,
# 	2: false
# }

# $sort = []

# def topological_sort
# 	vertices.each do |vertex_id, edges|
# 		if !seen[vertex_is]
# 			dfs_visit_sort(vertex_id)
# 		end
# 	end
# end

# def dfs_visit_sort(vertex_id)
# 	seen[vertex_id] = true

# 	vertices[vertex_id].each do |edge_id|
# 		if !seen[edge_id]
# 			dfs_visit_sort(edge_id)
# 		end
# 	end

# 	$sort << vertex_id
# end





