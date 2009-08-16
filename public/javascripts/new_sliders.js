(function($) {
  
  var round_robin = function(length) {
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

  $.fn.linked_slider = function(){
    var sliders = this;
    var num_opts = sliders.length;
    var presets = round_robin(num_opts);

    var set_initial = function(){ 
      initial_value = $(this).slider('option', 'value'); 
    };
    
    var raise_others = function(diff){
      diff = Math.abs(diff);
      var ret = new Array(num_opts);
      var skip_id = Number(this.id.split('_')[1]);
      
      for(var i=0; i < num_opts; i++) { // get current values
        ret[i] = Number($('#slider_' + i).slider('option', 'value'));
      };
      ret.splice(skip_id, 1); // ignore the slider we just changed
      
      var i=0;
      while(i < diff){ // calculate the new values
        for(var j=0; j < num_opts - 1; j++){
          if(!(ret[j] >= 100)) {
            ret[j] += 1;
            i++;
            if(i==diff){ break; }
          };
        };
      };
      
      for(var i=0; i < num_opts; i++){ // assign the new values
        if(i != skip_id){ $('#slider_' + i).slider('option', 'value', ret.splice(0, 1)); }
      };
    };
    var lower_others = function(diff){ alert('lo'); };
    
    var adjust_others = function(){
      var diff = $(this).slider('option', 'value') - initial_value;
      if (diff > 0){ new_vals = this.lower_others(diff); }
      if (diff < 0){ new_vals = this.raise_others(diff); }
      update_inputs();
    };
    
    var update_inputs = function(){
      for(var i=0; i < num_opts; i++){
        var new_val = $('#slider_' + i).slider('option', 'value');
        $('#slider_input_' + i).attr('value', Number(new_val)); 
      };
    };
    
    return sliders.each(function(){      
      $(this).slider({ // make div a jQuery UI slider
        value: presets.splice(0,1)[0],
        start: set_initial, 
        stop: adjust_others
      });
      this.raise_others = raise_others;
      this.lower_others = lower_others;
    });
  };
})(jQuery);

$(document).ready(function() {
  $('.slider').linked_slider();
});