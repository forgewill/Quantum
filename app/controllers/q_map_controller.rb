class QMapController < ApplicationController
  def index
  end

  def tree
    root_id = params[:root_id]
    if root_id && !root_id.empty?
      @root = QResource.find(root_id)
      @hierarchy = @root.outgoing(:contains).depth(1)

      @bread_crumbs = @root.incoming(:contains).depth(:all)
    end
  end

  def track
  end

end
