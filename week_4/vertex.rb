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