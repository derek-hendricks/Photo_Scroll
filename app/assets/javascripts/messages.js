$(function() {
  
  $(".img-responsive").hover(function() {
    $author = $(this);
    showFavourite($author);
  });

  $( ".effect" ).hide();
  
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
    
    $(".img-responsive").hover(function() {
      $author = $(this);
      showFavourite($author);
    });
  
  });
  function showFavourite($author) {
    $author_width = $author[0]['width'];
    $add_favourite = $author.prev();
    $add_favourite.css({ width: $author_width });
    $add_favourite.slideDown( "ease" );
  }
  function runEffect($gravatar) {
    $title = $gravatar.prev();
    $title.hide();
    $effect = $gravatar.find(".effect");
    $effect.toggle( "clip", 500 );
  }
});
  
    