// Disqus.com universal code snippet
var disqus_shortname = 'municipality'; // required: replace example with your forum shortname
var developer = 1
// The following are highly recommended additional parameters. Remove the slashes in front to use.
var disqus_identifier = 'unique_dynamic_id_1234';
var disqus_url = 'http://example.com/permalink-to-page.html';

/* * * DON'T EDIT BELOW THIS LINE * * */
(function() {
  var dsq = document.createElement('script');
  dsq.type = 'text/javascript';
  dsq.async = true;

  dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();