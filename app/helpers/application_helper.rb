module ApplicationHelper
  def background
    colors = ['416672','5a8696','a5869c','738c5a','3f6571','4d656f','129a7e','1e6481','e9dcd5','81965e','3f3f0f','2a574d','a85819','848e4a','102f3b','443051','166354','bcc157','496e54','c4cb9e','bee4ea']

    raw("<style type='text/css'>body{background: \##{colors[rand(colors.count)]};}</style>")
  end
end