function instr()
{
      let timeline = [];

      for(var i = 0; i < instrImg.length; i++){
            var instr = {
                  type: "image-keyboard-response",
                  stimulus: instrImg[i],
                  stimulus_height: screen.height/2, // Size of the instruction depending on the size of the participants' screen
                  choices: [32], // 32, spacebar //[37,39], left and right arrows
                  data: {
                        test_part: "instr",
                  },
            };
            timeline.push(fullscreenExp); // Makes sure the participants remain in fullscreen
            timeline.push(instr);
      };


      return timeline;
} // end function
