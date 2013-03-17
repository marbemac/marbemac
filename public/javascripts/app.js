$(document).ready(function() {

    $('.portfolio-item').each(function(i) {
        var position = $(this).position();
        console.log(position);
        console.log('min: ' + position.top + ' / max: ' + parseInt(position.top + $(this).height()));
        $(this).scrollspy({
            min: position.top - 300,
            max: position.top + $(this).height(),
            onEnter: function(element, position) {
                if(console) console.log('entering ' +  $(element).data('name'));
                $(".portfolio-links .on").removeClass('on');
                $(".portfolio-links ."+$(element).data('name')).addClass('on');

                // Fade image
                $(element).addClass('on').find('img').stop().animate({opacity:1}, 2500);
            },
            onLeave: function(element, position) {
                if(console) console.log('leaving ' +  $(element).data('name'));
                $(element).removeClass('on').find('img').stop().animate({opacity:0}, 300);
            }
        });
    });

    $('.bwWrapper').BlackAndWhite({
        hoverEffect : false,
        webworkerPath : '/javascripts/',
        responsive:true,
        invertHoverEffect: false,
        speed: {
            fadeIn: 200,
            fadeOut: 800
        }
    });

    // Fade in images so there isn't a color "pop" document load and then on window load
    $(".bwWrapper .photo").css('opacity', 0);

    $.localScroll({
    });

});