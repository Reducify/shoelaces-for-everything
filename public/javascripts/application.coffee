# trigger forms that use link submits instead
formSubmit = ->
  # clicking links with .formSubmit submits the form
  $('.formSubmit').click ->
    $(this).parents('form').submit()

    return false

  # for ie, hitting enter submits forms with hidden submit buttons
  if jQuery.browser.msie || $.browser.safari
    $('input').keypress (e) ->
        if e.keyCode == 13
          $(this).parents('form').submit()
          return false

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

deleteItem = ->
  $('.delete').click ->
    window.location = '/destroy/' + $(this).attr('data-id') if confirm("You sure about that?")

    return false

validate = ->
  $('form').submit ->
    error = false

    # if we're on edit or new, validate
    if $('#edit').length == 1 || $('#new').length == 1
      title = $('#something_title').val()
      image = $('#something_something').val()

      if title == ''
        $('#titleError span').html('looks like you forgot your title').parent().fadeIn()
        error = true
      else
        $('#titleError').fadeOut()

      if !image
        $('#imageError span').html('looks like you did\'t choose an image').parent().fadeIn()
        error = true
      else
        $('#imageError').fadeOut()

    if error
      return false
    else
      return true


# check the flash divs for notices or errors
checkForFlash = ->
  flash('notice', $('#flashNotice').html()) unless $('#flashNotice').html() == ''
  flash('error', $('#flashError').html()) unless $('#flashError').html() == ''


# set an error or notice
flash = (type, message) ->
  # get the flash object
  flashObj = $('#bodyFlash')

  # set the flash class
  if type == 'error'
    flashObj.removeClass('flashNotice').addClass('flashError')
  else if type == 'notice'
    flashObj.removeClass('flashError').addClass('flashNotice')

  # set the text
  flashObj.html(message)

  # show and hide the notice
  flashObj.stop(true).fadeIn().delay(5250).fadeOut()


# run on load
$(window).load ->
  formSubmit()
  thumbs()
  deleteItem()
  validate()
  checkForFlash()