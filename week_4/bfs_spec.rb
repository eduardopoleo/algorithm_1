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

describe Graph do
	describe '#add_vertex' do
		context 'when the vertex does not exist' do
			before do 
				@graph = Graph.new
				@graph.add_vertex(1, 2)
			end

			it 'creates vertecis if they do not exist' do
				expect(@graph.vertices.size).to eq(2)
			end

			it 'sets up the relationship between vertex' do
				expect(@graph.vertices[0].edges.size).to eq(1)
			end
		end

		context 'when the vertex already exist' do

			before do 
				@graph = Graph.new
				@graph.add_vertex(1,2)
				@graph.add_vertex(1,3)
				@graph.add_vertex(2,3)
			end

			it 'does not add new vertices to the graph if the vertex already exist' do
				expect(@graph.vertices.size).to eq(3)
			end

			it 'associates sets the vertices association' do
				expect(@graph.vertices[0].edges.map(&:id)).to match_array([2,3])
			end
		end
	end	
end


