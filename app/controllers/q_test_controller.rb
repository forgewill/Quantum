class QTestController < ApplicationController
  def index
    @qt = {}
    @qt["root"] = QResource.find(params[:qtest_id])
  end

  def solve
    index = 0
    testid = ""

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
    redirect_to :action => :report, :ssid => params[:session_id], :qtest_id => testid
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
    #0d1d82e43970ffc4105fabc53ba2c379
    #9cfb13f2950ebafa3c4a0c8e95b4c830

    test_id = params[:qtest_id].to_i
    ssid = params[:ssid]
    tphid = 12

    phlist = Neo4j.query{ test = node(test_id); tph = node(tphid); ph = node; test > ':consists_of' > ph > ':is_type' > tph; ret(ph).asc(ph[:position]) }.to_a
    phs = Array.new(phlist.count, {}) #phs[1][:id] = 25

    prlist = Neo4j.query{ test = node(test_id); pr = node; ph = node; test > ':consists_of' > ph > ':hold_on' > pr; ret(pr, ph).asc(ph[:position]) }.to_a


    phlist.each_with_index do |ph, i|
      phs[i] = {}
      phs[i][:id] = ph.first[1].id
      #@report = @report.to_s + i.to_s + ph.first[1].id.to_s
    end
    phs[0][:weight] = 10
    phs[1][:weight] = 15
    @report = phs[1][:id].to_s + "|" + phs[0][:weight].to_s + "|" + phs[1][:weight].to_s
  end

end
