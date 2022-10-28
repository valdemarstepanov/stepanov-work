class GraphGenerator
  
  def call(pools)
    File.open("graph.dot", "w") { |f| f.write(pools.includes(:profile).root.to_dot_digraph) }
    GraphViz.parse( "graph.dot", :path => "/" ).output(:png => "app/assets/images/graph.png")
  end
end
