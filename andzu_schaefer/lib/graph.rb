require "byebug"

class Vertex
  attr_accessor :in_edges, :out_edges, :value, :visited

  def initialize(value)
    @in_edges = []
    @out_edges = []
    @value = value
    @visited = false
  end

  def visited?
    !!@visited
  end 

  def descendants
    res = []
    out = @out_edges.dup
    until out.empty?
      res.push(out.pop.to_vertex)
    end
    res
  end

  def destroy!
    neighbors = []
    @in_edges.each {|e| e.destroy!}
    # debugger
    # p @out_edges.length
    until @out_edges.empty?
      # p "deleting edge"
      e = @out_edges.shift
      neighbors.push(e.to_vertex)
      e.destroy!
    end

    # @out_edges.each do |e|
    #   p "******************"
    #   p @out_edges.length
    #   p "deleting edge"
    #   neighbors.push(e.to_vertex)
    #   e.destroy!
    #   p @out_edges.length
    # end
    # p @out_edges.length
    neighbors
  end

  def zero_in_degree?
    @in_edges.empty?
  end

  def in_degree
    @in_edges.length
  end

end

class Edge
  attr_accessor :cost, :from_vertex, :to_vertex

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    from_vertex.out_edges.push(self)
    to_vertex.in_edges.push(self)
    @cost = cost
  end

  def destroy!
    @from_vertex.out_edges.delete(self)
    @to_vertex.in_edges.delete(self)
    @from_vertex = nil
    @to_vertex = nil
    @cost = nil
  end
end

v = []
(0...6).each {|i| v.push Vertex.new(i)}

e1 = Edge.new(v[0], v[1])
e1 = Edge.new(v[0], v[3])
e1 = Edge.new(v[0], v[2])

v[0].destroy!
