require 'pry'

require_relative './vertex'
require_relative './graph'

class DfsGraph < Graph
	def dfs_path(vertex_id)
		path = []
		q = [vertices[0]]

		catch :break do
			while !q.empty? do
				v = q.pop
				v.mark_as_seen
				path << v.id

				# I truly see an vertex when I take a look at its edges.
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

	def dfs_visit(vertex_id, vertex)
		vertex.mark_as_seen
		$path << vertex.id
		
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
end