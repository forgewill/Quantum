class QParagraphController < ApplicationController
  def index
  end

  def show
    if (params[:id] != nil)
      @paragraph = QResource.find(params[:id])
      @p_units = @paragraph.outgoing(:consists_of).sort_by {|unit| unit[:position]}
    end
  end

end
