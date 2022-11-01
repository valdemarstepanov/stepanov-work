class GraphGenerator
  
  def call(pools, user_id)
    File.open("/tmp/graph.dot", "w") { |f| f.write(pools.roots.to_dot_digraph(pools, user_id)) }
    GraphViz.parse( "/tmp/graph.dot", :path => "/" ).output(:png => "app/assets/images/graph3.png")
  end
end
