$.fn.inputfocus = function(params) {
    params = $.extend({
        focus_class: 'focus',
        value: ''
    }, params);

    this.each(function() {
        $(this).focus(function() {
            $(this).addClass(params.focus_class);
            this.value = (this.value == params.value) ? '' : this.value;
        });
        $(this).blur(function() {
            $(this).removeClass(params.focus_class);
            this.value = (this.value == '') ? params.value : this.value;
        });
    });
    return this;
};

if (typeof Element.insert !== "function") {
    //If not, hook it onto the $().append method.
    Element.insert = function (elem, ins) {
        $("#" + elem).append(ins.bottom);
    };
}

$(document).ready(function () {
    $('#show_form').click(function() {
        $('#main').slideDown('slow', function() {
            // Animation complete.
        });
    });

    $('.pagination a').live("click", function () {
        $('#main .pagination').html('Page is loading...');
        $.get(this.href, null, null, 'script');

        return false;
    });

    $('#show_hide_link a').click(function() {
        $('#anonymous_user_fields').slideToggle(300);

        return false;
    });

});