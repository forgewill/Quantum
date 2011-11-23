class QParagraphController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    if (params[:id] != nil)
      @paragraph = QResource.find(params[:id])
      #@p_units = @paragraph.outgoing(:consists_of).sort_by {|unit| unit[:position]}
      @p_units = @paragraph.outgoing(:consists_of).sort_by(&:position)

      #Paragraph as SUBJECT, i.e. Paragraph -> object
      need_to_learn = @paragraph.outgoing(:need_to_learn)
      based_on = @paragraph.incoming(:need_to_learn)
      @rel_res = {"NeedToLearn" => need_to_learn, "BasedOn" => based_on}
    end
  end

  def relation
    if (params[:id] != nil)
      @paragraph = QResource.find(params[:id])
    end
  end

end
