class QTestController < ApplicationController
  def index
    if params[:qtest_id] != nil
      @qtest = Hash.new
      @qtest["root"] = QResource.find(params[:qtest_id]) #Get QTest node
      @qtest["session_id"] ||= ActiveSupport::SecureRandom.hex #Generate Random Session ID

      @qtest["problems_list"] = Neo4j.query("START n=node({qtest_id}), t=node({_ph_type_id})
                                    MATCH (n)-[:consists_of]->(x)-[:hold_on]->(y),
                                    (x)-[:is_type]->(t)
                                    RETURN y",
                                            'qtest_id' => @qtest["root"].id.to_i,
                                            '_ph_type_id' => 12)

      #@qtest["_phs_list"] = @qtest["root"].outgoing(:consists_of)
    end
  end

  def solve
    #Neo4j::Transaction.run do
    #  answer = QResource.find(params[:user_chose_answer])
    #  user = User.find(current_user.id)
    #  Neo4j::Relationship.new(:chose_answer, user, answer)
    #end
    @res = 1 if params[:answer_1].empty?
    redirect_to :action => :report, :res => @res
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def report
  end

end
