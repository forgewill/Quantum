class QMatrixController < ApplicationController
  def index
    @qmatrix = {}
    disc_id = 59
    theme_type_id = 110

    #1 MATRIX
    matrix = Neo4j.query{ discipline = node(disc_id); chapter = node; theme = node; theme_type = node(theme_type_id); discipline > ':contains' > chapter > ':contains' > theme; theme > ':is_type' > theme_type; ret(theme).asc(theme[:note]).limit(45) }.to_a

    marray = []
    matrix.each_with_index do |theme,i|
      marray[i] = {:note => theme.first[1][:note].to_i, :id => theme.first[1].id, :title => theme.first[1][:title]}
    end
    marray = marray.sort_by {|hsh| hsh[:note]}

    @qmatrix[:m] = marray

    #2 PARAMS
    parray = []
    @qmatrix[:m].each_with_index  do |theme, i|
      j = 0
      sum_hr = 0
      sum_vr = 0
      @qmatrix[:m].count.times do
        sbj = QResource.find(@qmatrix[:m].find {|x| x[:note] == i+1}[:id])
        obj = QResource.find(@qmatrix[:m].find {|x| x[:note] == j+1}[:id])
        sum_hr = sum_hr + 1 if (sbj.rels(:outgoing, :need_to_learn).to_other(obj)).count > 0 && i < j
        sum_vr = sum_vr + 1 if (sbj.rels(:incoming, :need_to_learn).to_other(obj)).count > 0 && i > j
        j=j+1
      end
      freq_h = sum_hr/((@qmatrix[:m].count - i - 1) > 0 && (@qmatrix[:m].count - i - 1) || 1)
      freq_v = sum_vr/(i > 0 && i || 1)
      parray[i] = {:note => theme[:note].to_i, :id => theme[:id], :freq_h => freq_h.to_f, :freq_v => freq_v.to_f}
    end

    @qmatrix[:p] = parray
  end

  def tree
  end

  def one
  end

end