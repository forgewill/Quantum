module QParagraphHelper
  def render_paragraph_unit(unit)
    html = ""
    if unit.outgoing(:is_type).first != nil
      case unit.outgoing(:is_type).first.title
        when 'Type_QParagraphLaw'
          html << '<div class="q-paragraph-law">'+ unit.body + '</div>'
        when 'Type_QParagraphDefinition'
          html << '<div class="q-paragraph-definition">'+ unit.body + '</div>'
        when 'Type_QParagraphBlock' then
          html << '<h3>'+unit.title+'</h3>'
          unit.outgoing(:consists_of).sort_by(&:position).each { |block_unit| html << render_paragraph_unit(block_unit) }
        when 'Type_QImageResource'
          html << image_tag(unit.bfile_url)
        when 'Type_QPlaceHolder' then
          html << render_paragraph_unit(unit.outgoing(:hold_on).first)
      end
    else
      #html << '<h3>'+unit.title+'</h3>' #TODO remove and change schema by merging blocks
      html << '<p>'
      html << unit.body
      html << '</p>'
    end
    html
  end
end