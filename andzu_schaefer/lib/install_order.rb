# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but


#*********all packages from 1..max_id exist.*****************

# N.B. this is how `npm` works.

# Import any files you need to

require_relative "topological_sort"


def install_order(arr)
  #packages will hold vertexes
  package_range = arr.flatten.max
  packages = (1..package_range).to_a.map {|p| Vertex.new(p)}

  #dependencies holds edges
  dependencies = []
  arr.each do |p, d|
    v1 = packages.select {|v| v.value == p}[0]
    v2 = packages.select {|v| v.value == d}[0]
    dependencies.push( Edge.new(v2, v1))
  end

  res = topological_sort(packages).map {|v| v.value}
  res
end
