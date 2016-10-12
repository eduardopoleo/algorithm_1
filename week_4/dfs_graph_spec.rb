require 'rspec'
require_relative './dfs_graph'

describe DfsGraph do
	describe '#dfs_path' do
		it 'returns the dfs path to obtain the vertex' do
			graph = described_class.new()
				
			graph.add_vertex(1,2)
			graph.add_vertex(1,3)
			graph.add_vertex(2,4)
			graph.add_vertex(3,5)		
			graph.add_vertex(5,6)		
			graph.add_vertex(4,6)		
			graph.add_vertex(4,5)		

			expect(graph.dfs_path(6)).to eq([1,2,4,6])
		end
	end

	describe '#dfs_path_recursive' do
		it 'returns the dfs path to obtain the vertex' do
			graph = described_class.new()
				
			graph.add_vertex(1,2)
			graph.add_vertex(1,3)
			graph.add_vertex(2,4)
			graph.add_vertex(3,5)		
			graph.add_vertex(5,6)		
			graph.add_vertex(4,6)		
			graph.add_vertex(4,5)		

			expect(graph.dfs_path_recursive(6)).to eq([1,2,4,6])
		end
	end
end


