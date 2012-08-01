require 'spec_helper'

describe QMatrixController do

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

  describe "GET 'one'" do
    it "returns http success" do
      get 'one'
      response.should be_success
    end
  end

end
