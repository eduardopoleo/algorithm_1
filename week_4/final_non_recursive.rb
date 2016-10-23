# Build the graph using hash and arrays
require 'pry'

time1 = Time.now

file = File.open('data_set.txt', 'r')
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
  vertex ? vertex[:edges] << line[1] : $vertices[line[0]] = { id: line[0], seen: false, edges: [line[1]] }

  # Edge case where there's an edge that does not have 'edges' and otherwise would never be created
  edge = $vertices[line[1]]
  $vertices[line[1]] = { id: line[1] ,seen: false, edges: [] } unless edge
end	


$vertices.each do |vertex_id, info|
	vertex = $vertices_reverse[vertex_id]
  $vertices_reverse[vertex_id] = { id: vertex_id, seen: false, edges: [] } unless vertex

	info[:edges].each do |edge|
		reverse_vertex = $vertices_reverse[edge]

		if reverse_vertex
			reverse_vertex[:edges] << vertex_id
		else
			$vertices_reverse[edge] = { id: edge, seen: false, edges: [vertex_id] }
		end
	end
end

def mark_seen(vertex)
	vertex[:seen] = true
end

def scc_sort
	$vertices.each do |id, vertex|
		if !vertex[:seen]
			dfs_sort(vertex)
		end
	end
end


def dfs_sort(vertex)
	q = [vertex]

	while !q.empty? do
		v = q.pop
		if v.is_a?(String)
			$sort << v
		else
			if !v[:seen] 
				mark_seen(v)
				q << v[:id]
				# have to reverse the edges otherwise it would yield a different result than 
				# the recursive version.
				v[:edges].reverse.each do |e|
					edge = $vertices[e]
					if !edge[:seen]
						q << edge
					end
				end
			end
		end
	end

	$sort
end

def dfs_visit(vertex)
	q = [vertex]

	while !q.empty? do
		v = q.pop
		mark_seen(v)

		v[:edges].each do |e|
			edge = $vertices_reverse[e]
			if !edge[:seen]
				$scc << edge[:id]
				q << edge
			end
		end
		
	end

	$scc
end

scc_sort
# $abalon = $sort.map(&:to_i)

while !$sort.empty? do
	vertex_id = $sort.pop
	vertex = $vertices_reverse[vertex_id]

	if !vertex[:seen]
		$scc << vertex[:id]
		dfs_visit(vertex)
		$all_scc << $scc.uniq
		$scc = []
	end
end

# p $all_scc

# p $all_scc.map(&:size).sort
p $all_scc.map(&:size).sort.slice(-5..-1).reverse


# time2 = Time.now

# benchmark = (time2 - time1)

# p benchmark

