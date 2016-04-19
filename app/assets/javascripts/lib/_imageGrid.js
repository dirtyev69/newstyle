// (function( $ ){

//   $.fn.imageGrid = function( options ) {

//     var settings = $.extend( {
//       rowCount: 3,
//       grid: 0,
//       rowHeight: 150
//     }, options);

//     var self = this;

//     // console.log(this.children().size());

//     var len = this.find('img').length;

//     this.imagesLoaded(function() {
//       var step;
//       if ($(window).width() < 768) {
//         step = 2;
//       } else {
//         step = settings.rowCount;
//       }
//       setupGrid(step, len);

//       $(window).resize(function() {

//         if ($(window).width() < 768) {
//           step = 2;
//         } else {
//           step = settings.rowCount;
//         }
//         setupGrid(step, len);
//       });
//     });



//     function setupGrid(step, len){
//       var images = [];
//       var l;
//       for (l = 0; l < len;  l++) {
//         images.push(self[0].querySelectorAll("img")[l]);
//       }

//       var $element, elementH, elementW, height, i, j, k, s, width;

//       for (i = 0; i < len;  i += step) {
//         s = 0;
//         for (j = 0; j < step;  j++) {
//           if (i + j <= len - 1) {
//             $element = $(images[i + j]);
//             elementH = $element.height();
//             elementW = $element.width();
//             s += (elementW / elementH);
//           }
//         }

//         for (k = 0; k < step;  k++) {
//           if (i + k <= len - 1) {
//             $element = $(images[i + k]);
//             elementH = $element.height();
//             elementW = $element.width();

//             // console.log(i+k);
//             // if ( (i + k) === step) {
//             //   // console.log( i + k );
//             //   $(images[3]).css({ margin: 0});
//             // }

//             height = ($(window).width() - settings.grid*(step - 1)) / s;

//             $element.css({ marginRight: settings.grid + 'px'});
//             $element.css({ height: height + 'px' });

//             width = (elementW / elementH) * height;

//             $element.css({ width: width + 'px' });

//             // if last in row
//             if ( (i + k) === ( step - 1 )) {
//               $(images[i + k]).css({ marginRight: 0});
//             }
//           } else {
//             console.log('last');
//             console.log(i+k);
//             $(images[i + k - 1]).css({ marginRight: 0});
//           }
//         }
//       }
//     }

//   };
// })( jQuery );