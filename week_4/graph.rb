class Graph
	attr_reader :vertices

	def initialize
		@vertices = []
	end

	def add_vertex(vertex_id, edge_id)
		vertex1, new_vertex = find_or_create_vertex(vertex_id)
		vertices << vertex1 if new_vertex

		vertex2, new_vertex = find_or_create_vertex(edge_id)
		vertices << vertex2 if new_vertex

		vertex1.push_edge(vertex2)
	end

	private

	# This is just to build the graph, so
	def find_or_create_vertex(id)
		# wouldn't this defeat the purpose of graph searches...
		new_vertex = false
		vertex = vertices.find { |v| v.id == id}

		unless vertex
			vertex = Vertex.new(id) 
			new_vertex = true
		end

		[vertex, new_vertex]
	end
end

class Vertex
	attr_reader :id, :edges, :seen, :dist

	def initialize(id)
		@id = id
		@edges = []
		@seen = false
	end

	def push_edge(other_vertex)
		edges << other_vertex
	end

	def mark_as_seen
		@seen = true
	end

	def unseen?
		!seen
	end

	def set_dist(dist)
		@dist = dist
	end
end