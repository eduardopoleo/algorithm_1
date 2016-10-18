require 'pry'

require_relative './graph'

class DfsGraph < Graph
	def dfs_path(vertex_id)
		path = []
		q = [vertices[0]]

		catch :break do
			while !q.empty? do
				v = q.pop #LIFO
				v.mark_as_seen
				path << v.id

				#Truly seen vertex are those which I've seen it's edges.
				v.edges.reverse.each do |e|
					###what we want to find###
					if e.id == vertex_id
						path << e.id
						throw :break
					end
					###what we want to find###

					if e.unseen?
						q << e
					end
				end
			end
		end

		path
	end

	$path = []
	def dfs_path_recursive(vertex_id)
		catch :break do
			vertices.each do |v|
				if v.unseen?
					dfs_visit(vertex_id, v)
				end
			end
		end

		$path
	end
	# regular dfs scan
	def dfs_visit(vertex_id, vertex)
		vertex.mark_as_seen
		$path << vertex.id 
		# each vetices gets added inmmediately to the path 

		vertex.edges.each do |e|
			if e.id == vertex_id
				$path << e.id
				throw :break
			end

			if e.unseen?
				dfs_visit(vertex_id, e)
			end	
		end
	end

$sort = []
	def dfs_topological_sort(vertex_id)
		catch :break do
			vertices.each do |v|
				if v.unseen?
					dfs_visit_sort(vertex_id, v)
				end
			end
		end

		$sort.reverse
	end
	
# topological sort
	def dfs_visit_sort(vertex_id, vertex)
		vertex.mark_as_seen
		
		vertex.edges.each do |e|
			if e.unseen?
				dfs_visit_sort(vertex_id, e)
			end	
		end
		
		$sort << vertex.id 
		# The edges do not get added right away,
		# Only the vertex that is gets 
	end
end