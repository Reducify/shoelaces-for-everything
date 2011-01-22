thumbs = ->
  if $('#somethings').length == 1
    $('.thumb img').each ->
      # size and position the image
      scaleImage($(this), $(this).parent().width())
      
      # hide the image, then position it, the fade it in
      $(this).hide().css('top', 0).fadeIn()

# scale an image while keeping the aspect ration
scaleImage = (image, max)->
  w = image.width()
  h = image.height()

  way = ''

  # only rescale if the max is smaller than either dimension
  if w > max || h > max
    if w < h # taller
      aspect = w / h
      w = max * aspect
      h = max
      way = 'taller'
    else if w > h # wider
      aspect = h / w
      w = max
      h = max * aspect
      way = 'wider'
    else # square
      w = max
      h = max

  smaller = 0

  if way == 'wider'
    smaller = h
  else
    smaller = w

  margin = (max - smaller) / 2
  
  if way == 'wider'
    margin = margin + 'px 0 0 0'
  else
    margin = '0 0 0 ' + margin + 'px'

  # set the new width and height attributes of the image
  image.attr('width', w).attr('height', h).css('margin', margin)


# run on load
$(window).load ->
  thumbs()