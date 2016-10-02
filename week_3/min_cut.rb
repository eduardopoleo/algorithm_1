require 'pry'

class Vertex
  attr_accessor :own_vertices, :adjecent_vertices

  def initialize(initial_node_id, adjecent_vertices)
    @own_vertices = initial_node_id
    @adjecent_vertices = adjecent_vertices
  end

  def merge(other_vertex)
    self.adjecent_vertices = remove_redundant_edges(other_vertex)
    self.own_vertices = merge_own(other_vertex)
    self.adjecent_vertices = merge_adjecent(other_vertex)
  end

  private

  def remove_redundant_edges(other_vertex)
    self.adjecent_vertices - other_vertex.own_vertices
  end

  def merge_own(other_vertex)
    self.own_vertices + other_vertex.own_vertices
  end

  def merge_adjecent(other_vertex)
    # This allows for parallel edges
    self.adjecent_vertices + (other_vertex.adjecent_vertices - self.own_vertices)
  end
end

class Graph
  attr_accessor :vertices

  def initialize(vertices)
    @vertices = vertices
  end

  def pick_edge
    vertex1, edge = calculate_contraction_point
    vertex2, v2_index = find_vertex(edge)

    [vertex1, vertex2, v2_index]
  end

  def contract(vertex1, vertex2, v2_index)
    vertex1.merge(vertex2)
    vertices.delete_at(v2_index)
  end

  def calculate_min_cut
    vertices.first.adjecent_vertices.length
  end

  def size
    vertices.length
  end

  def find_vertex(edge)
    vertex_index = vertices.index{|v| v.own_vertices.include?(edge)}
    [vertices[vertex_index], vertex_index]
  end

  private

  def calculate_contraction_point
    vertex_index = rand(0...vertices.length)
    vertex1 = vertices[vertex_index]
    edge_index = rand(0...vertex1.adjecent_vertices.length)
    edge = vertex1.adjecent_vertices[edge_index]

    [vertex1, edge]
  end

end

min_cuts = []

for i in 0...200
  file = File.open('data_set.txt', 'r')
  lines = file.readlines
  file.close

  vertices = []
  lines.each do |l|
    l.chomp!
    line = l.split("\t")
    vertex = Vertex.new(line.slice(0...1), line.slice(1..-1))
    vertices << vertex
  end

  graph = Graph.new(vertices)

  while graph.size > 2 do
    vertex1, vertex2, v2_index = graph.pick_edge
    graph.contract(vertex1, vertex2, v2_index)
  end

  min_cuts << graph.calculate_min_cut
end

p min_cuts.min
