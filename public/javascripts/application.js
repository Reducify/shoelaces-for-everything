(function() {
  var checkForFlash, deleteItem, flash, formSubmit, shoelaceThumbs, validate;
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
      var error, image, shoelace, title;
      error = false;
      if ($('#edit').length === 1 || $('#new').length === 1) {
        title = $('#something_title').val();
        image = $('#something_something').val();
        shoelace = $('input:radio:checked').val();
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
        if (!shoelace) {
          $('#shoelaceError span').html('pick your shoelace').parent().fadeIn();
          error = true;
        } else {
          $('#shoelaceError').fadeOut();
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
  shoelaceThumbs = function() {
    return $('input[name=shoelace]').change(function() {
      $('.shoelaceThumb').removeClass('selected');
      return $('#shoelaceThumb' + $(this).val()).addClass('selected');
    });
  };
  $(window).load(function() {
    formSubmit();
    deleteItem();
    validate();
    checkForFlash();
    return shoelaceThumbs();
  });
}).call(this);
