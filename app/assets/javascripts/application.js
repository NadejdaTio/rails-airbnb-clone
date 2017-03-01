
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .



$(window).scroll(function() {
    if($(this).scrollTop() > 50)
    {
        $('.opaque-navbar').addClass('opaque');
    } else {
        $('.opaque-navbar').removeClass('opaque');
    }
});
