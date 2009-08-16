function setInitial(){
  prev_val = $(this).slider('values', 1);
}

function setInitialFromInput(){
  prev_val = $(this).attr('value');
}

function moveSlidersFromInput(){
  if($(this).attr('value') < 0 || $(this).attr('value') > 100 || $(this).attr('value') == "" || isNaN($(this).attr('value'))){
    $(this).attr('value', prev_val);
    return;
  }
  var diff = Number($(this).attr('value')) - Number(prev_val);
  var my_num = $(this).attr('id').split("_")[2];
  var my_slider = $('#slider_' + my_num);
  my_slider.slider('option', 'value', Number($(this).attr('value')));
  if(diff > 0) { lowerOthers(my_slider, Math.abs(diff)) }
  if(diff < 0) { raiseOthers(my_slider, Math.abs(diff)) }
  updateInputs();
}

function adjustOthers(){
  var diff = $(this).slider('option', 'value') - prev_val;
  if(diff > 0) { lowerOthers($(this), Math.abs(diff)) }
  if(diff < 0) { raiseOthers($(this), Math.abs(diff)) }
  updateInputs();
}

function updateInputs(){
  var sliders = $('.slider') // update the inputs
  for(var i=0; i<sliders.length; i++){
    var new_val = $('#slider_' + i).slider('option', 'value');
    $('#slider_input_' + i).attr('value', Number(new_val)); 
  }
}

function lowerOthers(skip_me, amount){
  var sliders = $('.slider');
  var assign_to = $('#slider_0');

  for(var i=0; i<amount; i++){
    for(var j=0; j<sliders.length; j++){
      if(assign_to.attr('id') == skip_me.attr('id')){
        assign_to = nextSlider(assign_to);
        continue;
      }
      if(assign_to.slider('option', 'value') == 0){
        assign_to = nextSlider(assign_to);
        continue;
      }
      var current_value = assign_to.slider('option', 'value');
      assign_to.slider('option', 'value', Number(current_value - 1));
      break;
    }
  assign_to = nextSlider(assign_to);
  }
}

function raiseOthers(skip_me, amount){
  var sliders = $('.slider');
  var assign_to = $('#slider_0');

  for(var i=0; i<amount; i++){
    for(var j=0; j<sliders.length; j++){
      if(assign_to.attr('id') == skip_me.attr('id')){
        assign_to = nextSlider(assign_to);
        continue;
      }
      if(assign_to.slider('option', 'value') == 100){
        assign_to = nextSlider(assign_to);
        continue;
      }
      var current_value = assign_to.slider('option', 'value');
      assign_to.slider('option', 'value', Number(current_value + 1));
      break;
    }
  assign_to = nextSlider(assign_to);
  }
}

function setValuesFromInputs(){
  var sliders = $('.slider') // update the inputs
  for(var i=0; i<sliders.length; i++){
    var new_val = $('#slider_input_' + i).attr('value'); 
    $('#slider_' + i).slider('option', 'value', new_val);
  }
}

function nextSlider(prev){
  var i = Number(prev.attr('id').split("_")[1]);
  i += 1;
  if(i >= $('.slider').length)
    i = 0;
  return $("#slider_" + i);
}

$(document).ready(function(){
  $(".slider").slider({
    animate: false, 
    start: setInitial, 
    stop: adjustOthers
  });

    $(".slider_input")
      .bind("focus", setInitialFromInput)
      .bind("blur", moveSlidersFromInput);

  setValuesFromInputs();
});