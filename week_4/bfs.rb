# Given a small graph how to see if a node with diven value exist
# Why not just load all the vertex and places them on an array?
# The reason we do BFS or DFS is becuase we want to understand the interaction
# between nodes: Like the relative path, shortest path connected components
# Also is you have data in your data base you wouldn't load all your nodes 
# in an array you will want to follow the chain somehow, but in this case how
# you keep track of what nodes you have visited? 
# Each node has an id and I guess we can cache the already queried elements
# so that we do no have to re issue the query.

require 'pry'

class Vertex
	attr_reader :id, :edges
	attr_accessor :seen

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
end


class Graph
	attr_reader :vertices

	def initialize
		@vertices = []
	end

	

	def bsf(vertex_id)
		s = vertices[0]
		path = [s.id]
		return path if s.id == vertex_id
		s.mark_as_seen
		q = [s]

		catch :breaking_the_habbit do
			while !q.empty? do
				v = q.shift
				v.edges.each do |e|
					if e.id == vertex_id
						path << e.id
						throw :breaking_the_habbit
					end

					if e.unseen?
						e.mark_as_seen
						q << e
						path << e.id
					end
				end
			end
		end

		path
	end
################################################
	def add_vertex(vertex_id, edge_id)
		vertex1, new_vertex = find_or_create_vertex(vertex_id)
		vertices << vertex1 if new_vertex

		vertex2, new_vertex = find_or_create_vertex(edge_id)
		vertices << vertex2 if new_vertex

		vertex1.push_edge(vertex2)
	end

	private
	# This is shitty. But I do not know how to move forward without this.
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

file = File.open('bfs_data_set.txt', 'r')

lines = file.readlines
file.close

graph = Graph.new()

lines.each do |l|
  l.chomp!
  line = l.split("\t")
  vertex_id, edge_id = line.slice(0..1)
  graph.add_vertex(vertex_id, edge_id )
end

