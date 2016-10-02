require 'rspec'
require_relative './scc.rb'

describe Vertex do
  describe '#push_edge' do
    it 'stores other vertes in the edge attribute' do
      vertex1 = described_class.new(1)
      vertex2 = described_class.new(2)
      vertex3 = described_class.new(3)

      vertex1.push_edge(vertex2)
      vertex1.push_edge(vertex3)

      expect(vertex1.edges.size).to eq(2)
    end
  end
end


describe Graph do
  describe '#add_edge' do
    it 'instantiate a new vertex if there is not existing vertex with that id' do
      graph = Graph.new
      graph.add_adge(1)
      
      expect()
    end
  end
end
