class QResourcesController < ApplicationController
  before_filter :authenticate_user!

  # GET /q_resources
  # GET /q_resources.json
  def index
    @q_resources = QResource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @q_resources }
    end
  end

  # GET /q_resources/1
  # GET /q_resources/1.json
  def show
    @q_resource = QResource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @q_resource }
    end
  end

  # GET /q_resources/new
  # GET /q_resources/new.json
  def new
    @q_resource = QResource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @q_resource }
    end
  end

  # GET /q_resources/1/edit
  def edit
    @q_resource = QResource.find(params[:id])
  end

  # POST /q_resources
  # POST /q_resources.json
  def create
    Neo4j::Transaction.run do
      @q_resource = QResource.new(params[:q_resource])
      @q_resource.save!
      respond_to do |format|
        if @q_resource.save
          format.html { redirect_to @q_resource, :notice => 'Q resource was successfully created.' }
          format.json { render :json => @q_resource, :status => :created, :location => @q_resource }
        else
          format.html { render :action => "new" }
          format.json { render :json => @q_resource.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /q_resources/1
  # PUT /q_resources/1.json
  def update
    Neo4j::Transaction.run do
      @q_resource = QResource.find(params[:id])
      @q_resource.update_attributes!(params[:q_resource])
      respond_to do |format|
        if @q_resource.update_attributes(params[:q_resource])
          format.html { redirect_to @q_resource, :notice => 'Q resource was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @q_resource.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /q_resources/1
  # DELETE /q_resources/1.json
  def destroy
    @q_resource = QResource.find(params[:id])
    @q_resource.bfile.remove!
    @q_resource.destroy

    respond_to do |format|
      format.html { redirect_to q_resources_url }
      format.json { head :ok }
    end
  end
end
