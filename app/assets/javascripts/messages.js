$(function() {
  $( ".effect" ).hide();
  
  function runEffect($gravatar) {
    $title = $gravatar.prev();
    $title.hide();
    $effect = $gravatar.find(".effect");
    $effect.toggle( "clip", 500 );
  }
  
  $("div.gravatar").click(function() {
    $gravatar = $(this);
    runEffect($gravatar);
  });
  
  $( document ).ajaxComplete(function() {
    $( ".effect" ).hide();
    
    $("div.gravatar").click(function() {
      $gravatar = $(this);
      runEffect($gravatar);
    });
  });
  
});
  
    