require 'securerandom'

class GraphGenerator
  
  def call(pools, user_id)
    File.open("/tmp/graph.dot", "w") { |f| f.write(Pool.to_dot_digraph(pools, user_id)) }
    GraphViz.parse( "/tmp/graph.dot", :path => "/" ).output(:png => "/tmp/graph7.png")
  end
end
