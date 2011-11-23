module QMapHelper
  def render_simple_map(root)
    html = ""

    root.incoming(:need_to_learn).depth(:all).reverse_each do |node|
      html << "<p>"+node.title+"</p>"
    end

    html
  end
end
