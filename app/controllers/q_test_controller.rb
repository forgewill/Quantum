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
      @ssid = QResource.new(:title => params[:session_id])
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
    #f2bf330901b0f94a19dd0c6ebee1688a -> R
    #prlist = Neo4j.query{ test = node(test_id); pr = node; ph = node; test > ':consists_of' > ph > ':hold_on' > pr; ret(pr, ph).asc(ph[:position]) }.to_a

    test_id = params[:qtest_id].to_i
    ssid = params[:ssid]
    ssid_q = Neo4j.query { lookup(QResource, "title", ssid) }.to_a
    tphid = 12
    trasw = 16

    phlist = Neo4j.query{ test = node(test_id); tph = node(tphid); ph = node; test > ':consists_of' > ph > ':is_type' > tph; ret(ph).asc(ph[:position]) }.to_a
    phs = Array.new(phlist.count, {}) #phs[1][:id] = 25
    rsm = Array.new(phlist.count, {})

    phlist.each_with_index do |ph, i|
      #fill the ID and Weight of each _phs
      phs[i] = {}
      phs[i][:id] = ph.first[1].id
      phs[i][:weight] = ph.first[1][:weight]

      #check the truth/falsity
      tf = Neo4j.query{ ph = node(phs[i][:id]); ssid_obj = node(ssid_q[0].first[1].id);  pr = node; asw = node; type_asw = node; ph > ':hold_on' > pr > ':contains' > asw > 'is_type' > type_asw; ssid_obj > ':selected' > asw; ret(type_asw)}.to_a
      phs[i][:solve] = (tf[0].first[1].id.to_s == trasw.to_s && 1) || 0
      #@report = @report.to_s + tf[0].first[1].id.to_s + "|"
      #@report = @report.to_s + phs[i][:solve].to_s + "|"

      #calculate Result matrix with T's
      rsm[i] = {}
      rsm[i][:id] = phs[i][:id]
      rsm[i][:t] = (phs[i][:solve].to_s == "1" && phs[i][:weight]) || 0

      #@report = @report.to_s + rsm[i][:t].to_s + "|"
    end

    phs.each_with_index do |ph, i|
      if ph[:solve].to_s == "1"
        ph_node = QResource.find(ph[:id])
        appliance_nodes = ph_node.outgoing(:need_to_solve)
        trust_nodes = ph_node.incoming(:need_to_solve)

        #appliance_nodes.each do |t|
        #  @report = @report.to_s + t.id.to_s
        #end
        #phs.select { |ph| ph[:id] == 22 }
        #prow = phs.select { |p| p[:id] == "22" }
        #@report = @report.to_s + ph[:id].to_s + "out-" + appliance_nodes.count.to_s + "in-" + trust_nodes.count.to_s + "|"

        if appliance_nodes.count == 0 && trust_nodes.count == 0
          rsm[i][:f] = phs[i][:weight]
        end

        if appliance_nodes.count > 0 && trust_nodes.count == 0
          appliance_ratio = 0
          sr_ratio = 0
          rl_ratio = 0

          appliance_nodes.each do |anode|
            r = phs.select { |p| p[:id] == anode.id.to_s }[0][:solve]
            l = QResource.find(ph[:id]).rels(:outgoing, :need_to_solve).to_other(QResource.find(anode.id)).first[:weight]
            sr_ratio = sr_ratio.to_f + r.to_f*l.to_f
            rl_ratio = rl_ratio.to_f + l.to_f
          end

          appliance_ratio = sr_ratio + (1 - rl_ratio)
          rsm[i][:f] = phs[i][:weight]*appliance_ratio
          @report = rsm[i][:f]
        end

        if appliance_nodes.count == 0 && trust_nodes.count > 0

        end

        if appliance_nodes.count > 0 && trust_nodes.count > 0
          appliance_nodes.each do |anode|
            r = phs.select { |p| p[:id] == anode.id.to_s }[0][:solve]
            l = QResource.find(ph[:id]).rels(:outgoing, :need_to_solve).to_other(QResource.find(anode.id))
          end
        end
      else
        rsm[i][:f] = 0
      end
    end


    #@report = phs[0][:id].to_s + "|" + phs[0][:weight].to_s + "|" + phs[0][:solve].to_s
  end

end
