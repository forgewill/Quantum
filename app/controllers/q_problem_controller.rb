class QProblemController < ApplicationController
  def index
  end

  def show
    @problem = QResource.find(params[:problem_id]) if (params[:problem_id] != nil)
    @answers = @problem.outgoing(:has_answer).depth(1)

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
