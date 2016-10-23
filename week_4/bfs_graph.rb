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

require_relative './graph'

class BfsGraph < Graph
	def bfs_value(vertex_id, i)
		#For these simple cases the starting point is not relevant	
		s = vertices[i]
		return s.id if s.id == vertex_id
		s.mark_as_seen
		q = [s]
		result = :not_found

		catch :breaking_the_habbit do
			while !q.empty? do
				v = q.shift
				v.edges.each do |e|
					###what we want to find###
					if e.id == vertex_id
						result = e.id
						throw :breaking_the_habbit
					end
					###what we want to find###

					if e.unseen?
						e.mark_as_seen
						q << e
					end
				end
			end
		end

		result
	end

	def bsf_path(vertex_id, i)
		#For these simple cases the starting point is not relevant
		s = vertices[i]
		path = [s.id]
		return path if s.id == vertex_id
		s.mark_as_seen
		q = [s]
		dist = 0

		catch :breaking_the_habbit do
			while !q.empty? do
				v = q.shift
				v.edges.each do |e|
					###what we want to find###
					if e.id == vertex_id
						path << e.id
						throw :breaking_the_habbit
					end
					###what we want to find###

					if e.unseen?
						e.mark_as_seen
						q << e
						# extra code
						path << e.id
					end
				end
			end
		end

		path
	end

	def bsf_shortest_dist(vertex_id)
		#For these simple cases the starting point is not relevant
		s = vertices[0]
		path = [s.id]
		return path if s.id == vertex_id
		s.mark_as_seen
		q = [s]
		s.set_dist(0)
		result = 0

		catch :breaking_the_habbit do
			while !q.empty? do
				v = q.shift
				v.edges.each do |e|
					###what we want to find###
					if e.id == vertex_id
						result = v.dist + 1
						throw :breaking_the_habbit
					end
					###what we want to find###

					if e.unseen?
						e.mark_as_seen
						q << e
						# extra code
						e.set_dist(v.dist + 1)
					end
				end
			end
		end

		result
	end

	def bfs_directed_graph(vertex_id)
		result = ''
		vertices.each_with_index do |v,i|
			if v.unseen?
				result = bfs_value(vertex_id, i)
				break unless result == :not_found
			end
		end

		result
	end

	def scc
		# This only works for undirected graphs. And the point is that
		# you'll be able to find the size of isolated components
		# Does not work on a directed graph cuz the count may get skew depending
		# on the vertex you start.
		result = []
		vertices.each_with_index do |v,i|
			if v.unseen?
				count = bfs_for_scc(i)
				result << count
			end
		end

		result.sort { |x,y| y <=> x }
	end

	def bfs_for_scc(i)
		#For these simple cases the starting point is not relevant	
		s = vertices[i]
		s.mark_as_seen
		q = [s]
		count = 1

		catch :breaking_the_habbit do
			while !q.empty? do
				v = q.shift
				v.edges.each do |e|
					if e.unseen?
						count += 1
						e.mark_as_seen
						q << e
					end
				end
			end
		end

		count
	end
end

# file = File.open('data_set.txt', 'r')
# lines = file.readlines
# graph = Graph.new()
# line_number = 0
# result = []
# count = 0
# lines.each do |l|
# 	puts "#{count+=1}"
# end

# result = graph.scc

# puts "result: #{result.sort}"
