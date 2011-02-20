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