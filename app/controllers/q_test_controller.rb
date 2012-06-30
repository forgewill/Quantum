class QTestController < ApplicationController
  def index
    @qt = {}
    @qt["root"] = QResource.find(params[:qtest_id])
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
      @qtest = {}
      @qtest["root"] = QResource.find(params[:qtest_id])
      @qtest["session_id"] ||= SecureRandom.hex #Generate Random Session ID

      id = params[:qtest_id].to_i
      @qtest["problems_list"] = Neo4j.query{ test = node(id); pr = node; ph = node; test > ':consists_of' > ph > ':hold_on' > pr; ret(pr).asc(ph[:position]) }.to_a
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
    #TODO Formula
    @report = "Report!"
  end

end
