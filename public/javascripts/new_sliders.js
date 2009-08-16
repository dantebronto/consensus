$(document).ready(function() {
  var sliders = $('.slider');
  var num_opts = sliders.length;
  var presets = roundRobin(num_opts);
 
  for(var i=0; i < num_opts; i++){
    $('#slider_' + i).slider({ 
      value: presets[i],
      start: setInitial, 
      stop: adjustOthers
    });
  };
});

function setInitial(){ 
  initialValue = $(this).slider('option', 'value'); 
}

function adjustOthers(){
  var diff = $(this).slider('option', 'value') - initialValue; 
  if(diff > 0) { alert('lower others'); } //lowerOthers($(this), Math.abs(diff)) }
  if(diff < 0) { alert('raise others'); } //raiseOthers($(this), Math.abs(diff)) }
  //updateInputs();
}

function roundRobin(length) {
  var ara = new Array(length);
  ara = $.map(ara, function(){ return 0; });
  var j=0;
  for(var i=0; i < 100; i++){
    ara[j] += 1;
    if(j == (length - 1)){ j = 0; } 
    else { j++; }
  }
  return ara;
}

// (function($) {
// 
//   // Private class variable
//   var a;
// 
//   // Private class method
//   function doSomething() {}
// 
//   // Public class method
//   $.myPlugin = function() {
// 
//     // Private instance variable
//     var b;
// 
//     doSomething();
//     doSomethingElse();
// 
//     // Private instance method
//     function doSomethingElse() {}
//   };
// })(jQuery);
