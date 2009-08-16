(function($) {
  $.fn.linked_slider = function(){
    var sliders = this;
    var num_opts = sliders.length;

    var slider_set_initial = function(){ 
      initial_value = $(this).slider('option', 'value'); 
    };
    
    var input_set_initial = function(){
      initial_value = Number($(this).attr('value'));
    };
    
    var get_current_values = function(){
      var ret = new Array(num_opts);
      for(var i=0; i < num_opts; i++) {
        ret[i] = Number($('#slider_' + i).slider('option', 'value'));
      };
      return ret;
    };
    
    var raise_others = function(diff, elem, cur_vals){
      var i=0;
      while(i < diff){
        for(var j=0; j < num_opts - 1; j++){
          if(!(cur_vals[j] >= 100)) {
            cur_vals[j] += 1;
            i++;
            if(i==diff){ break; }
          };
        };
      };
      return cur_vals;
    };
    
    var lower_others = function(diff, elem, cur_vals){
      var i=0;
      while(i < diff){
        for(var j=0; j < num_opts - 1; j++){
          if(!(cur_vals[j] <= 0)) {
            cur_vals[j] -= 1;
            i++;
            if(i==diff){ break; }
          };
        };
      };
      return cur_vals;
    };
    
    var input_adjust_others = function(){
      var elem = $(this);
      var val = elem.attr('value');
      if(val < 0 || val > 100 || val == "" || isNaN(val)){
        elem.attr('value', initial_value);
        return;
      }
      var diff = Number(val) - initial_value;
      var skip_id = elem.attr('id').split("_").reverse()[0];
      var my_slider = $('#slider_' + skip_id);
      my_slider.slider('option', 'value', Number(val));
      
      adjust_others_common(diff, elem, skip_id);
    };
    
    var slider_adjust_others = function(){
      var elem = $(this);
      var diff = elem.slider('option', 'value') - initial_value;
      var skip_id = elem.attr('id').split('_').reverse()[0];
      
      adjust_others_common(diff, elem, skip_id);
    };
    
    var adjust_others_common = function(diff, elem, skip_id){
      var cur_vals = get_current_values();
      cur_vals.splice(skip_id, 1); // ignore the slider we just changed
      
      if (diff > 0){ cur_vals = lower_others(diff, elem, cur_vals); }
      if (diff < 0){ cur_vals = raise_others(Math.abs(diff), elem, cur_vals); }
      
      for(var i=0; i < num_opts; i++){ // assign the new values
        if(i != skip_id){ $('#slider_' + i).slider('option', 'value', cur_vals.splice(0, 1)); }
      };
      
      update_inputs();
    };
    
    var update_inputs = function(){
      for(var i=0; i < num_opts; i++){
        var new_val = $('#slider_' + i).slider('option', 'value');
        $('#slider_input_' + i).attr('value', Number(new_val)); 
      };
    };
    
    var set_initial_values_from_inputs = function(){
      for(var i=0; i<num_opts; i++){
        var new_val = $('#slider_input_' + i).attr('value'); 
        $('#slider_' + i).slider('option', 'value', new_val);
      };
    };
    
    return sliders.each(function(){      
      $(this).slider({ // make div a jQuery UI slider
        start: slider_set_initial, 
        stop: slider_adjust_others
      });
      
      $(".slider_input")
        .bind("focus", input_set_initial)
        .bind("blur", input_adjust_others);
      
      set_initial_values_from_inputs();
    });
  };
})(jQuery);

$(document).ready(function() {
  $('.slider').linked_slider();
});