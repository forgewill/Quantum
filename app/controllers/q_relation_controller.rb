class QRelationController < ApplicationController
  def index
  end

  def edit
  end

  def new
  end

  def create
    Neo4j::Transaction.run do
      subj = QResource.find(params[:idSubject])
      obj = QResource.find(params[:idObject])
      @rel_new = Neo4j::Relationship.new(params[:rel_type], subj, obj)
    end
    redirect_to :action => "show", :rel_id => @rel_new.id
  end

  def show
    @relation = Neo4j::Relationship.load(params[:rel_id])
  end

  def delete
  end

  def destroy
    Neo4j::Transaction.run do
      @relation = Neo4j::Relationship.load(params[:idRelation])
      @relation.del()
    end

    redirect_to :action => "index"
  end

end
