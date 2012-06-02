class QTestController < ApplicationController
  def index

  end

  def solve
    index = 0

    Neo4j::Transaction.run do
      testid = QResource.find(params[:test_id])
      @ssid = QResource.new(:ssid => params[:session_id])
      @ssid.save!
      user = User.find(current_user.id)
      Neo4j::Relationship.new(:refers_to, @ssid, user)
      Neo4j::Relationship.new(:refers_to, @ssid, testid)
    end

    params[:count_of_quests].to_i.times do
      index += 1
      Neo4j::Transaction.run do
        answer = QResource.find(params["answer_"+index.to_s])
        Neo4j::Relationship.new(:selected, @ssid, answer)
      end unless params["answer_"+index.to_s].nil?
    end
    redirect_to :action => :report, :ssid => params[:session_id]
  end

  def show
    if params[:qtest_id] != nil
      @qtest = Hash.new
      @qtest["root"] = QResource.find(params[:qtest_id]) #Get QTest node
      @qtest["session_id"] ||= ActiveSupport::SecureRandom.hex #Generate Random Session ID

      @qtest["problems_list"] = Neo4j.query("START n=node({qtest_id}), t=node({_ph_type_id})
                                    MATCH (n)-[:consists_of]->(x)-[:hold_on]->(y),
                                    (x)-[:is_type]->(t)
                                    RETURN y",
                                            'qtest_id' => @qtest["root"].id.to_i,
                                            '_ph_type_id' => 181)
    end
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
