require 'spec_helper'

describe QMapController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'tree'" do
    it "returns http success" do
      get 'tree'
      response.should be_success
    end
  end

  describe "GET 'track'" do
    it "returns http success" do
      get 'track'
      response.should be_success
    end
  end

end
