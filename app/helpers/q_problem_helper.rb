module QProblemHelper
  def problem_is_right(problem_id)
    @problem_right = Neo4j.query("START y=node({problem_id}), u=node({user_id}), ts=node({qsolution_type_id})
                                  MATCH (y)-[:has_answer]->(x)-[:is_type]->(ts), (u)-[:chose_answer]->(x)
                                  RETURN y",
                                 'problem_id' => problem_id,
                                 'user_id' => current_user.id.to_i,
                                 'qsolution_type_id' => 126,
                                 'qproblem_type_id' => 123)

    #@problem_right
    true if @problem_right.count > 0
  end
end
