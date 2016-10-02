# Given a small graph how to see if a node with diven value exist
require 'pry'

class Vertex
	attr_reader :id, :edges

	def initialize(id)
		@id = id
		@edges = []
	end

	def push_edge(other_vertex)
		edges << other_vertex
	end
end


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
	# This is shitty. But I do not know how to move forward without this.
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