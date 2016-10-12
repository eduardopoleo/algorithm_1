require 'rspec'
require_relative './bfs'

describe Vertex do
	describe '#push_edge' do
		it 'push other vertex into @edges attribute' do
			vertex1 = described_class.new(1)
			vertex2 = described_class.new(2)

			vertex1.push_edge(vertex2)
			expect(vertex1.edges.size).to eq(1)
		end
	end	
end

describe BfsGraph do
	describe '#add_vertex' do
		context 'when the vertex does not exist' do
			before do 
				@graph = described_class.new
				@graph.add_vertex(1, 2)
			end

			it 'creates a new vertex' do
				expect(@graph.vertices.size).to eq(2)
			end

			it 'sets up the relationship between vertices' do
				expect(@graph.vertices[0].edges.size).to eq(1)
			end
		end

		context 'when the vertex already exist' do

			before do 
				@graph = described_class.new
				@graph.add_vertex(1,2)
				@graph.add_vertex(1,3)
				@graph.add_vertex(2,3)
			end

			it 'does NOT add new vertices' do
				expect(@graph.vertices.size).to eq(3)
			end

			it 'sets the vertices associations' do
				expect(@graph.vertices[0].edges.map(&:id)).to match_array([2,3])
			end
		end
	end


	describe '#bfs_value' do
		context 'when vertex are in the same group' do
			it 'returns the path that led to the vertex for a simple graph' do
				graph = described_class.new()

				graph.add_vertex(1,2)
				graph.add_vertex(2,3)
				graph.add_vertex(3,4)
				graph.add_vertex(4,1)

				expect(graph.bfs_value(3, 0)).to eq(3)
			end

			it 'returns the path that led to the vertex a more complicated graph starting out from a vertex that has a possible path' do
				graph = described_class.new()
				
				graph.add_vertex(1,2)
				graph.add_vertex(1,3)
				graph.add_vertex(2,4)
				graph.add_vertex(3,4)
				graph.add_vertex(3,5)		
				graph.add_vertex(5,6)		
				graph.add_vertex(4,6)		
				graph.add_vertex(4,5)		

				expect(graph.bfs_value(6, 0)).to eq(6)
			end
		end
	end	

	describe '#bfs_shortest_path' do
		context 'when vertex are in the same group' do
			it 'returns the shortest distance for a relative complex graph starting from a node that makes it possible to get there' do
				graph = described_class.new()

				graph.add_vertex(1,2)
				graph.add_vertex(1,3)
				graph.add_vertex(2,4)
				graph.add_vertex(3,4)
				graph.add_vertex(3,5)		
				graph.add_vertex(5,6)		
				graph.add_vertex(4,6)		
				graph.add_vertex(4,5)		

				expect(graph.bsf_shortest_dist(6)).to eq(3)
			end
		end
	end	

	describe '#bfs_directed_graph' do
		it 'finds information about a given vertex even if the starting point makes it imposible to transverse' do
				graph = described_class.new()

				graph.add_vertex(3,4)
				graph.add_vertex(4,5)
				graph.add_vertex(1,3)
				graph.add_vertex(4,6)		
				graph.add_vertex(1,2)
				graph.add_vertex(3,5)		
				graph.add_vertex(2,4)
				graph.add_vertex(5,6)		

				#change the graph interface to find something else...color etc....
				expect(graph.bfs_directed_graph(1)).to eq(1)
		end
	end

	describe '#bfs_scc' do
		it 'finds the size of the connected components' do
			graph = described_class.new()

			graph.add_vertex(1,3)
			graph.add_vertex(1,5)
			graph.add_vertex(3,5)
			graph.add_vertex(5,7)
			graph.add_vertex(5,9)

			graph.add_vertex(2,4)

			graph.add_vertex(8,6)
			graph.add_vertex(6,10)
			graph.add_vertex(10,8)

			expect(graph.scc).to eq([5, 3, 2])
		end		
	end
end


