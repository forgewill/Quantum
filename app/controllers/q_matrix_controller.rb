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


  def wr_tree (id)
    tree = '{'
    unit = QResource.find(id)
    tree = tree + '"name": ' + '"' + unit.id.to_s + '", "frequency": 5'
    if unit.incoming(:need_to_learn).count > 0
      tree = tree + ', "children": ['
      ch_count = unit.incoming(:need_to_learn).count
      unit.incoming(:need_to_learn).each_with_index do |parent, i|
        if ch_count == 1
          tree = tree + wr_tree(parent.id)
        end
        if ch_count > 1
          if ch_count == i+1
            tree = tree + wr_tree(parent.id)
          else
            tree = tree + wr_tree(parent.id) + ", "
          end
        end
      end
      tree = tree + ']'
    end
    tree = tree + '}'
    result = tree
  end

  def tree

    if params[:root_id] != nil
      @matrix = wr_tree(params[:root_id])
      #@matrix = QResource.find(params[:root_id]).incoming(:need_to_learn).depth(5)
      #@matrix = '{"name": "67", "children": [{"name": "66", "children": [{"name": "65"}]}, {"name": "65"}]}'
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @matrix }
    end
  end

  def one
  end

end
