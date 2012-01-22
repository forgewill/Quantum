class QProblemController < ApplicationController
  before_filter :authenticate_user!

  def index
    @didactic_unit = QResource.find(params[:root_id])
    @p_ref_d = Neo4j.query("START n=node({didactic_unit_id}), t=node({qproblem_type_id})
                                  MATCH (n)<-[:refers_to]-(x)-[:is_type]->(t)
                                  RETURN x",
                           'didactic_unit_id' => @didactic_unit.id.to_i,
                           'qproblem_type_id' => 123)
    @p_ref_d_right = Neo4j.query("START n=node({didactic_unit_id}), u=node({user_id}), ts=node({qsolution_type_id}), tp=node({qproblem_type_id})
                                  MATCH (n)<-[:refers_to]-(y)-[:is_type]->(tp), (y)-[:has_answer]->(x)-[:is_type]->(ts), (u)-[:chose_answer]->(x)
                                  RETURN y",
                                 'didactic_unit_id' => @didactic_unit.id.to_i,
                                 'user_id' => current_user.id.to_i,
                                 'qsolution_type_id' => 126,
                                 'qproblem_type_id' => 123)
  end

  def create
    Neo4j::Transaction.run do
      #Get typed nodes
      answer_r_node = QResource.find(126) # TODO Need to relate to "TYPE" instead "ID"
      answer_w_node = QResource.find(127) # TODO Need to relate to "TYPE" instead "ID"
      problem_type_node = QResource.find(123) # TODO Need to relate to "TYPE" instead "ID"
      taxonomy_level_node = QResource.find(params[:taxonomy_level]) # TODO Need to relate to "TYPE" instead "ID"

      #Get related paragraph
      related_paragraph = QResource.find(params[:related_paragraph])

      #Create problem node
      @problem_node = QResource.new
      @problem_node.title = params[:problem_body].slice(0..45)+"..."
      @problem_node.body = params[:problem_body]
      @problem_node.isource = params[:problem_isource]
      @problem_node.weight = params[:problem_weight]

      #Create answer nodes
      r_answer = QResource.new
      r_answer.body = params[:problem_r_answer]

      w_answer_first = QResource.new
      w_answer_first.body = params[:problem_w_answer_first]

      w_answer_second = QResource.new
      w_answer_second.body = params[:problem_w_answer_second]

      w_answer_third = QResource.new
      w_answer_third.body = params[:problem_w_answer_third]

      #Saving nodes
      @problem_node.save!
      r_answer.save!
      w_answer_first.save!
      w_answer_second.save!
      w_answer_third.save!

      #Create relationships
      Neo4j::Relationship.new(:is_type, @problem_node, problem_type_node)
      Neo4j::Relationship.new(:refers_to, @problem_node, related_paragraph)
      Neo4j::Relationship.new(:refers_to, @problem_node, taxonomy_level_node)
      Neo4j::Relationship.new(:has_answer, @problem_node, r_answer)
      Neo4j::Relationship.new(:has_answer, @problem_node, w_answer_first)
      Neo4j::Relationship.new(:has_answer, @problem_node, w_answer_second)
      Neo4j::Relationship.new(:has_answer, @problem_node, w_answer_third)
      Neo4j::Relationship.new(:is_type, r_answer, answer_r_node)
      Neo4j::Relationship.new(:is_type, w_answer_first, answer_w_node)
      Neo4j::Relationship.new(:is_type, w_answer_second, answer_w_node)
      Neo4j::Relationship.new(:is_type, w_answer_third, answer_w_node)
    end
    redirect_to :action => "show", :problem_id => @problem_node.neo_id
  end

  def show
    @problem = QResource.find(params[:problem_id]) if (params[:problem_id] != nil)
    @answers = @problem.outgoing(:has_answer).depth(1)

    ################## HISTORY OF ANSWERS ##############################################################################
    @history_answers = Neo4j.query("START n=node({problem_id}), u=node({user_id})
                                  MATCH (n)-[:has_answer]->(x)<-[:chose_answer]-(u)
                                  RETURN x.body",
                                   'problem_id' => @problem.id.to_i,
                                   'user_id' => current_user.id.to_i)

    if @problem.outgoing(:has_solution).depth(1).first != nil
      @solution = @problem.outgoing(:has_solution).depth(1).first.outgoing(:consists_of).sort_by(&:position)
    end

    @answers.each do |asw|
      if asw.outgoing(:is_type).first.title == 'Type_QParagraphProblem-answer-R'
        @asw_right = asw # this is right answer
      end
    end

    user = User.find(current_user.id)
    if user.rels(:chose_answer).find{|rel| rel.end_node == @asw_right}
      #if user.rels(:chose_answer).outgoing.to_other(@asw_right)
      @right = true
    else
      @right = false
    end
    ####################################################################################################################

    @taxonomy_level = Neo4j.query("START n=node({problem_id}), t=node({tax_level_id})
                                  MATCH (n)-[:refers_to]->(x)-[:is_type]->(t)
                                  RETURN x.title",
                                  'problem_id' => @problem.id.to_i,
                                  'tax_level_id' => 198)

    @related_paragraphs = Neo4j.query("START n=node({problem_id}), t=node({paragraph_type_id})
                                      MATCH (n)-[:refers_to]->(x)-[:is_type]->(t)
                                      RETURN x",
                                      'problem_id' => @problem.id.to_i,
                                      'paragraph_type_id' => 78)

  end

  def solution
  end

  def solve
    Neo4j::Transaction.run do
      answer = QResource.find(params[:user_chose_answer])
      user = User.find(current_user.id)
      Neo4j::Relationship.new(:chose_answer, user, answer)
    end

    redirect_to :back

  end

end
