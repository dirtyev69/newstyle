(function( $ ){

  $.fn.imageGridNew = function( options ) {

    var settings = $.extend( {
      rowCount: 3,
      grid: 0,
      rowHeight: 150
    }, options);

    var self = this;

    // console.log(this.children().size());

    var len = this.find('img').length;


    // for (var l = 0; l < len;  l++) {
    //   self[0].querySelectorAll("img")[l].style.opacity = "0";
    // }

    this.imagesLoaded(function() {

      var images = [];
      var l;
      for (l = 0; l < len;  l++) {
        images.push(self[0].querySelectorAll("img")[l]);
        // self[0].querySelectorAll("img")[l].style.opacity = "0";
      }

      var wWidth = $(window).width();

      // step = settings.rowCount;
      setupGrid(wWidth, images);

      var resizeTimer;
      $(window).on('resize', function(e) {

        var wWidth = $(window).width();

        setupGrid(wWidth, images);
        // clearTimeout(resizeTimer);

      });
    });



    function setupGrid(wWidth, images){
      var $element, elementH, elementW, height, i, j, k, s, hI, wI, width, heightN;


      // var images = [];
      // var l;
      k = 0;
      while (images[k]) {
        images[k].opacity = "0";
        $(images[k]).removeClass('imgAnim');
        images[k].style.display = "none";
        // self[0].querySelectorAll("img")[l].style.opacity = "0";
        k++;
      }

      var buf = [];
      i = 0;
      s = 0;
      while (images[i]) {
        hI = $(images[i]).height();
        wI = $(images[i]).width();

        buf.push(images[i]);
        s += wI / hI;

        heightN = wWidth / s;
        console.log(s);
        if (( heightN >= settings.minRowHeight ) && ( heightN <= settings.maxRowHeight )) {

          for (j = 0; j < buf.length;  j++) {
            $element = $(buf[j]);
            elementH = $element.height();
            elementW = $element.width();

            $element.css({ height: heightN + 'px' });

            width = (elementW / elementH) * heightN;

            $element.css({ width: width + 'px' });

            $(buf[j]).addClass('imgAnim');
            // buf[j].style.Transition = 'opacity .5s easy';
            // buf[j].style.WebkitTransition = 'opacity .5s easy';
            // buf[j].style.MozTransition = 'opacity .5s easy';
            buf[j].style.opacity = "1";
            buf[j].style.display = "inline-block";

          }
          s = 0;
          buf = [];
        }

        if ( heightN < settings.minRowHeight ) {
          s = 0;
          buf = [];
          // i += ( buf.length - 1 );
        }

        i++;
      }



      // for (i = 0; i < len;  i += step) {
      //   s = 0;
      //   for (j = 0; j < step;  j++) {
      //     if (i + j <= len - 1) {
      //       $element = $(images[i + j]);
      //       elementH = $element.height();
      //       elementW = $element.width();
      //       s += (elementW / elementH);
      //     }
      //   }

      //   for (k = 0; k < step;  k++) {
      //     if (i + k <= len - 1) {
      //       $element = $(images[i + k]);
      //       elementH = $element.height();
      //       elementW = $element.width();

      //       // console.log(i+k);
      //       // if ( (i + k) === step) {
      //       //   // console.log( i + k );
      //       //   $(images[3]).css({ margin: 0});
      //       // }

      //       height = ($(window).width() - settings.grid*(step - 1)) / s;

      //       $element.css({ marginRight: settings.grid + 'px'});
      //       $element.css({ height: height + 'px' });

      //       width = (elementW / elementH) * height;

      //       $element.css({ width: width + 'px' });

      //       // if last in row
      //       if ( (i + k) === ( step - 1 )) {
      //         $(images[i + k]).css({ marginRight: 0});
      //       }
      //     } else {
      //       console.log('last');
      //       console.log(i+k);
      //       $(images[i + k - 1]).css({ marginRight: 0});
      //     }
      //   }
      // }
    }

  };
})( jQuery );