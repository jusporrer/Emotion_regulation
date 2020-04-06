/* jspsych-fullscreen.js
 * Josh de Leeuw
 *
 * toggle fullscreen mode in the browser
 *
 */


jsPsych.plugins.fullscreen = (function() {


  var plugin = {};

  plugin.info = {
    name: 'fullscreen',
    description: '',
    parameters: {
      fullscreen_mode: {
        type: jsPsych.plugins.parameterType.BOOL,
        pretty_name: 'Fullscreen mode',
        default: true,
        array: false,
        description: 'If true, experiment will enter fullscreen mode. If false, the browser will exit fullscreen mode.'
      },
      message: {
        type: jsPsych.plugins.parameterType.STRING,
        pretty_name: 'Message',
        default: '<p>The experiment will switch to full screen mode when you press the button below</p>',
        array: false,
        description: 'HTML content to display above the button to enter fullscreen mode.'
      },
      button_label: {
        type: jsPsych.plugins.parameterType.STRING,
        pretty_name: 'Button label',
        default:  'Continue',
        array: false,
        description: 'The text that appears on the button to enter fullscreen.'
      },
      delay_after: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Delay after',
        default: 0,
        array: false,
        description: 'The length of time to delay after entering fullscreen mode before ending the trial.'
      },
      check_fullscreen: {
        type: jsPsych.plugins.parameterType.BOOL,
        pretty_name: 'check_fullscreen',
        default: null,
        description: 'If it is already fullscreen then does nothing'
      },
    }
  }

  plugin.trial = function(display_element, trial) {

    let cursornone = document.getElementById("cursornone").innerHTML;

   function mousefullscreen1 (){
      var res = cursornone.replace("none", "default");
      document.getElementById("cursornone").innerHTML = res;}

    function mousefullscreen2 (){
       var res = cursornone.replace("default", "none");
       document.getElementById("cursornone").innerHTML = res;}

    // if(trial.check_fullscreen = false){
      if(trial.fullscreen_mode){
        mousefullscreen1();
        display_element.innerHTML = trial.message + '<button id="jspsych-fullscreen-btn" class="jspsych-btn">'+trial.button_label+'</button>';
        var listener = display_element.querySelector('#jspsych-fullscreen-btn').addEventListener('click', function() {
          var element = document.documentElement;
          if (element.requestFullscreen) {
            element.requestFullscreen();
          } else if (element.mozRequestFullScreen) {
            element.mozRequestFullScreen();
          } else if (element.webkitRequestFullscreen) {
            element.webkitRequestFullscreen();
          } else if (element.msRequestFullscreen) {
            element.msRequestFullscreen();
          }
          endTrial();
        });
      }

          if (!document.fullscreenElement || !document.mozFullScreenElement || !document.webkitFullscreenElement || !document.msFullscreenElement) {
            mousefullscreen1();
            display_element.innerHTML = trial.message + '<button id="jspsych-fullscreen-btn" class="jspsych-btn">'+trial.button_label+'</button>';
            var listener = display_element.querySelector('#jspsych-fullscreen-btn').addEventListener('click', function() {
              var element = document.documentElement;
              if (element.requestFullscreen) {
                element.requestFullscreen();
              } else if (element.mozRequestFullScreen) {
                element.mozRequestFullScreen();
              } else if (element.webkitRequestFullscreen) {
                element.webkitRequestFullscreen();
              } else if (element.msRequestFullscreen) {
                element.msRequestFullscreen();
              }
              endTrial();
            });
          } //end if
//        });

        if (document.fullscreenElement || document.mozFullScreenElement || document.webkitFullscreenElement || document.msFullscreenElement) {
          endTrial();}


    function endTrial() {
      display_element.innerHTML = '';
      mousefullscreen2();

      jsPsych.pluginAPI.setTimeout(function(){

        var trial_data = {
          "rt": 999,
          "stimulus": "null",
          "stimulus2": "null",
          "position": 999,
          "key_press": 999,
          "response": 999,
          "start_point": 999,
        };

        jsPsych.finishTrial(trial_data);

      }, trial.delay_after);

    }

  };

  return plugin;
})();
