$('#show_form').click(function() {
    $('#main').slideDown('slow', function() {
        // Animation complete.
    });
});
if (typeof Element.insert !== "function") {
    //If not, hook it onto the $().append method.
    Element.insert = function (elem, ins) {
        $("#" + elem).append(ins.bottom);
    };
}
$(function () {
  $('.pagination a').live("click", function () {
    $('#main .pagination').html('Page is loading...');
    $.get(this.href, null, null, 'script');
    return false;
  });
}); 