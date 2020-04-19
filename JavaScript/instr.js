function instr(instrImg)
{
      var timeline = [];
      //let cursornone = document.getElementById("cursornone").innerHTML;
      console.log(instrImg[1])

      
      var instr1 = {
            type: "image-keyboard-response",
            stimulus: "instructions/instructionsDiapo/Slide1.jpg",
            stimulus_height: 300,
            choices: ["f","g"], //[37,38], // left and right arrows
            data: {
                  test_part: "instr",
            },
      }

      timeline.push(instr1);


      return timeline;
} // end function
