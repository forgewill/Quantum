module QMatrixHelper
  def exrel_need_to_learn(subject, object)
    html = ""
    sbj = QResource.find(subject)
    obj = QResource.find(object)
    html << "1" if (sbj.rels(:outgoing, :need_to_learn).to_other(obj)).count > 0
    html
  end
end
