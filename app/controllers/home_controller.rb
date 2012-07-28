class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @index = {}

    # Artificial Neural Network

    net = Ai4r::NeuralNetwork::Backpropagation.new([2, 3, 1])

    example = [[100,25],[24,1],[1,100],[45,100]]
    result = [[0],[0],[1],[1]]

    # Train the network
    #20000.times do |i|
    #  j = i % result.length
    #  net.train(example[j], result[j])
    #end

    #@index = net.eval([25,1])

    ####################################################################################################################

    # Statistical

    #@first = Statsample::Shorthand.rnorm(1000,0,10)
    @first = 1000.times.collect {rand}.to_scale
    @second = 1000.times.collect {rand}.to_scale

    array = []
    #@first.each_with_index do |x,i|
    #  array[i] = @first[i] > 2 && @first[i] || @first[i]+20
    #end

    #@second = array.to_scale

    @index[:first_a] = @first[0]
    @index[:first_b] = @second[0]
  end

end
