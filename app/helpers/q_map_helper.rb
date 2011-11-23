module QMapHelper
  def render_simple_map(root)
    html = ""
    index = 0
    root.incoming(:need_to_learn).depth(:all).reverse_each do |node|
      index = index + 1
      html << "<p>"+index.to_s+". "+node.title+"</p>"
    end

    html
  end
end
