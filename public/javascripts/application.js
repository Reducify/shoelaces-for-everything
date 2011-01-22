(function() {
  var scaleImage, thumbs;
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
  $(window).load(function() {
    return thumbs();
  });
}).call(this);
