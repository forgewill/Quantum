class QParagraphController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    if (params[:id] != nil)
      @paragraph = QResource.find(params[:id])
      #@p_units = @paragraph.outgoing(:consists_of).sort_by {|unit| unit[:position]}
      @p_units = @paragraph.outgoing(:consists_of).sort_by(&:position)

      #Paragraph as SUBJECT, i.e. Paragraph -> object
      need_to_learn = @paragraph.outgoing(:need_to_learn)
      based_on = @paragraph.incoming(:need_to_learn)
      @rel_res = {"NeedToLearn" => need_to_learn, "BasedOn" => based_on}

      #### REFERS_TO QProblem ###
      @problems_all = Neo4j.query("START n=node({paragraph_id}), t=node({qproblem_type_id})
                                  MATCH (n)<-[:refers_to]-(x)-[:is_type]->(t)
                                  RETURN x",
                                  'paragraph_id' => @paragraph.id.to_i,
                                  'qproblem_type_id' => 123)
      @problems_all_right = Neo4j.query("START n=node({paragraph_id}), u=node({user_id}), ts=node({qsolution_type_id}), tp=node({qproblem_type_id})
                                  MATCH (n)<-[:refers_to]-(y)-[:is_type]->(tp), (y)-[:has_answer]->(x)-[:is_type]->(ts), (u)-[:chose_answer]->(x)
                                  RETURN y",
                                        'paragraph_id' => @paragraph.id.to_i,
                                        'user_id' => current_user.id.to_i,
                                        'qsolution_type_id' => 126,
                                        'qproblem_type_id' => 123)
      ##########################
    end
  end

  def relation
    if (params[:id] != nil)
      @paragraph = QResource.find(params[:id])
    end
  end

end
