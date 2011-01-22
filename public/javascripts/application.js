(function() {
  var checkForFlash, deleteItem, flash, formSubmit, scaleImage, thumbs, validate;
  formSubmit = function() {
    $('.formSubmit').click(function() {
      $(this).parents('form').submit();
      return false;
    });
    if (jQuery.browser.msie || $.browser.safari) {
      return $('input').keypress(function(e) {
        if (e.keyCode === 13) {
          $(this).parents('form').submit();
          return false;
        }
      });
    }
  };
  thumbs = function() {
    if ($('#somethings').length === 1) {
      return $('.thumb img').each(function() {
        scaleImage($(this), $(this).parent().width());
        return $(this).hide().css('top', 0).fadeIn();
      });
    }
  };
  scaleImage = function(image, max) {
    var aspect, h, margin, smaller, w, way;
    w = image.width();
    h = image.height();
    way = '';
    if (w > max || h > max) {
      if (w < h) {
        aspect = w / h;
        w = max * aspect;
        h = max;
        way = 'taller';
      } else if (w > h) {
        aspect = h / w;
        w = max;
        h = max * aspect;
        way = 'wider';
      } else {
        w = max;
        h = max;
      }
    }
    smaller = 0;
    if (way === 'wider') {
      smaller = h;
    } else {
      smaller = w;
    }
    margin = (max - smaller) / 2;
    if (way === 'wider') {
      margin = margin + 'px 0 0 0';
    } else {
      margin = '0 0 0 ' + margin + 'px';
    }
    return image.attr('width', w).attr('height', h).css('margin', margin);
  };
  deleteItem = function() {
    return $('.delete').click(function() {
      if (confirm("You sure about that?")) {
        window.location = '/destroy/' + $(this).attr('data-id');
      }
      return false;
    });
  };
  validate = function() {
    return $('form').submit(function() {
      var error, image, title;
      error = false;
      if ($('#edit').length === 1 || $('#new').length === 1) {
        title = $('#something_title').val();
        image = $('#something_something').val();
        if (title === '') {
          $('#titleError span').html('looks like you forgot your title').parent().fadeIn();
          error = true;
        } else {
          $('#titleError').fadeOut();
        }
        if (!image) {
          $('#imageError span').html('looks like you did\'t choose an image').parent().fadeIn();
          error = true;
        } else {
          $('#imageError').fadeOut();
        }
      }
      if (error) {
        return false;
      } else {
        return true;
      }
    });
  };
  checkForFlash = function() {
    if ($('#flashNotice').html() !== '') {
      flash('notice', $('#flashNotice').html());
    }
    if ($('#flashError').html() !== '') {
      return flash('error', $('#flashError').html());
    }
  };
  flash = function(type, message) {
    var flashObj;
    flashObj = $('#bodyFlash');
    if (type === 'error') {
      flashObj.removeClass('flashNotice').addClass('flashError');
    } else if (type === 'notice') {
      flashObj.removeClass('flashError').addClass('flashNotice');
    }
    flashObj.html(message);
    return flashObj.stop(true).fadeIn().delay(5250).fadeOut();
  };
  $(window).load(function() {
    formSubmit();
    thumbs();
    deleteItem();
    validate();
    return checkForFlash();
  });
}).call(this);
