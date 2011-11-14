require "spec_helper"

describe QResourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/q_resources").should route_to("q_resources#index")
    end

    it "routes to #new" do
      get("/q_resources/new").should route_to("q_resources#new")
    end

    it "routes to #show" do
      get("/q_resources/1").should route_to("q_resources#show", :id => "1")
    end

    it "routes to #edit" do
      get("/q_resources/1/edit").should route_to("q_resources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/q_resources").should route_to("q_resources#create")
    end

    it "routes to #update" do
      put("/q_resources/1").should route_to("q_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/q_resources/1").should route_to("q_resources#destroy", :id => "1")
    end

  end
end
