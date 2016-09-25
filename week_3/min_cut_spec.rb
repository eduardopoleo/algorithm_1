require 'rspec'
require_relative './min_cut'

describe Vertex do
  describe '#merge' do
    let(:vertex1) { described_class.new([1,2,3], [4,5,6,7]) }
    let(:vertex2) { described_class.new([4,5,6], [7,8,9,1,2]) }
    let(:vertex3) { described_class.new([7,8,9], [1,2,4]) }

    before do
      vertex1.merge(vertex2)
    end

    it 'merges the own_vertives of both vertices' do
      expect(vertex1.own_vertices).to eq([1,2,3,4,5,6])
    end

    it 'remove redundant adjacent_vertices and adds the new adjecent' do
      expect(vertex1.adjecent_vertices).to match_array([7,7,8,9])
    end
  end
end


describe Graph do
  let(:vertex1) { Vertex.new([1,2,3], [4,5,6,7]) }
  let(:vertex2) { Vertex.new([4,5,6], [7,8,9]) }
  let(:vertex3) { Vertex.new([7,8,9], [1,2,4]) }

  before do
    vertices = [vertex1, vertex2, vertex3]
    @graph = Graph.new(vertices)
    # @graph.contract(vertex1, vertex2, 1)
  end

  describe 'find_vertex' do
    fit '' do
      expect(@graph.find_vertex(7)).to eq([vertex3, 2])
    end
  end
end
