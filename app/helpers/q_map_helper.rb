module QMapHelper
  def render_simple_map(root)
    html = ""
    index = 0
    root.incoming(:need_to_learn).depth(:all).reverse_each do |node|
      index = index + 1
      html << "<p>"+index.to_s+". "+node.title+"</p>"
    end

    html
  end

  def average_points(root)
    html = ""

    total = Neo4j.query("START n=node({root_id}), u=node({user_id}), ts=node({qsolution_type_id}), tp=node({qproblem_type_id})
                                      MATCH (n)-[:contains*1..1000]->(p)<-[:refers_to]-(y)-[:is_type]->(tp), (y)-[:has_answer]->(x)-[:is_type]->(ts), (u)-[:chose_answer]->(x)
                                      RETURN y",
                        'root_id' => root.to_i,
                        'user_id' => current_user.id.to_i,
                        'qsolution_type_id' => 126,
                        'qproblem_type_id' => 123)

    sum = 0
    total.each do |s|
      sum = sum + QResource.find(s.first[1].id).weight
    end

    html << sum.to_s
  end
end
