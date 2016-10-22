# Get a stack of vertices ordered by dfs_topological_sort
# Reverses the graph
# Clear the visited bolean
# Pops the elements from the stack and uses the dfs_visit                            t

require 'pry'

require_relative './graph'

$scc = []
$all_scc = []
$sort = []


class DfsGraph < Graph
	def dfs_topological_sort
		
		vertices.each do |v|
			if v.unseen?
				dfs_visit_sort(v)
			end
		end

		$sort.reverse
	end

	def mark_all_unseen
		vertices.each do |v|
			v.seen = false
		end
	end

	def find_by_id(vertex_id)
		vertices.find { |v| v.id == vertex_id }
	end
	
# topological sort
	def dfs_visit_sort(vertex)
		vertex.mark_as_seen
		
		vertex.edges.each do |e|
			if e.unseen?
				dfs_visit_sort(e)
			end	
		end
		
		$sort << vertex.id
		# The edges do not get added right away,
		# Only the vertex that is gets 
	end

	def dfs_visit(vertex)
		vertex.mark_as_seen
		
		# each vetices gets added inmmediately to the path 
		$scc << vertex.id

		vertex.edges.each do |e|
			if e.unseen?
				dfs_visit(e)
			end	
		end
	end
end

graph = DfsGraph.new()
	
graph.add_vertex(1,4)
graph.add_vertex(4,7)
graph.add_vertex(7,1)
graph.add_vertex(9,7)		
graph.add_vertex(9,3)		
graph.add_vertex(3,6)		
graph.add_vertex(6,9)		
graph.add_vertex(8,6)		
graph.add_vertex(8,5)		
graph.add_vertex(5,2)		
graph.add_vertex(2,8)		


graph.dfs_topological_sort

reverted_graph = DfsGraph.revert(graph)

reverted_graph.mark_all_unseen

while !$sort.empty? do
	vertex_id = $sort.pop
	vertex = reverted_graph.find_by_id(vertex_id)

	if vertex.unseen?
		reverted_graph.dfs_visit(vertex)
		$all_scc << $scc

		$scc = []
	end
end

p $all_scc