class QRelationController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def edit
  end

  def new
  end

  def newprop
  end

  def find
    if params[:nodeType] == "resource"
      Neo4j::Transaction.run do
        subject = QResource.find(params[:idSubject]) if !params[:idSubject].empty?
        object = QResource.find(params[:idObject]) if !params[:idObject].empty?

        @relations = subject.rels() if !subject.nil? && object.nil?
        @relations = object.rels() if !object.nil? && subject.nil?
        @relations = subject.rels.to_other(object) if !object.nil? && !subject.nil?
      end
    end
    if params[:nodeType] == "user"
      Neo4j::Transaction.run do
        subject = User.find(params[:idSubject]) if !params[:idSubject].empty?
        object = User.find(params[:idObject]) if !params[:idObject].empty?

        @relations = subject.rels() if !subject.nil? && object.nil?
        @relations = object.rels() if !object.nil? && subject.nil?
        @relations = subject.rels.to_other(object) if !object.nil? && !subject.nil?
      end
    end
  end

  def search
  end

  def create
    Neo4j::Transaction.run do
      subj = QResource.find(params[:idSubject])
      obj = QResource.find(params[:idObject])
      @rel_new = Neo4j::Relationship.new(params[:rel_type], subj, obj)
    end
    redirect_to :action => "show", :rel_id => @rel_new.id
  end

  def createprop
      Neo4j::Transaction.run do
        rel_id = params[:idRelation]
        @relation = Neo4j::Relationship.load(rel_id)
        @relation[params[:propType]] = params[:propValue]
      end
      redirect_to :action => "show", :rel_id => @relation.id
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
