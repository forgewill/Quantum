class QMatrixController < ApplicationController
  def index
    @qmatrix = {}
    disc_id = 59
    theme_type_id = 110

    matrix = Neo4j.query{ discipline = node(disc_id); chapter = node; theme = node; theme_type = node(theme_type_id); discipline > ':contains' > chapter > ':contains' > theme; theme > ':is_type' > theme_type; ret(theme).asc(theme[:note]) }.to_a

    marray = []
    matrix.each_with_index do |theme,i|
      marray[i] = {:note => theme.first[1][:note].to_i, :id => theme.first[1].id}
    end
    marray = marray.sort_by {|hsh| hsh[:note]}

    @qmatrix[:m] = marray
  end

  def tree
  end

  def one
  end

end
