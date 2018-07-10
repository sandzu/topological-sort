require_relative 'graph'
require "byebug"

# Implementing topological sort using both Khan's and Tarian's algorithms


def topological_sort(vertices)
  kahn_sort(vertices)
  # tarjan_sort(vertices)
end

#kahn
#worst case: only 1 vertex is appended to zero_in_degree each pass,
#resulting in O(n**2) runtime
def kahn_sort(vertices)
  # debugger
  ordered = []
  zero_in_degree = []
  vertices.each do |vertex|
    zero_in_degree.push(vertex) if vertex.zero_in_degree?
  end
  until zero_in_degree.empty?
    # p (zero_in_degree.map{|el| [el.value, e.in_degree]})
    vertex = zero_in_degree.shift
    # p vertex.value
    ordered.push(vertex)
    vertices.delete(vertex)
    # debugger
    neighbors = vertex.destroy!
    zero_in_degree += neighbors.select{|v| v.zero_in_degree? }
    # debugger
  end
  return [] unless vertices.empty?
  ordered
end


def tarjan_sort(vertices)
  # visited = vertices
  output = []
  # debugger
  until vertices.empty?
    v = vertices.pop
    v.descendants.each do |child|
      # return nil if child.visited
      return nil unless visit(child, output, vertices)
    end
    return false if v.visited?
    v.visited = true
    output.unshift(v)

  end
  output
end



def visit(vertex, output, vertices)
  vertices.delete(vertex)
  vertex.descendants.each do |child|
    # return nil if child.visited
    debugger unless visit(child, output, vertices)
  end
  return false if vertex.visited?
  vertex.visited = true
  output.unshift(vertex)
  true
end
