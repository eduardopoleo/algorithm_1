require 'pry'

class Vertex
  attr_reader :id, :edges

  def initialize(id)
    @id = id
    @edges= []
  end

  def push_edge(vertex)
    edges << vertex
  end

end


class Graph
	def add_edge(line)

	end

	def each(&block)
		Vertex.each_object do |v|
			block.call(v)
		end
	end

	def find_vertex(id)
		select do |v|
			v.id == id
		end
	end
end



# file = File.open('data_set.txt', 'r')
# lines = file.readlines
# file.close

# lines.each do |l|
#   l.chomp!
#   line = l.gsub("\n", "").split(" ")
#   Graph.add_vertex(line)
# end	

   