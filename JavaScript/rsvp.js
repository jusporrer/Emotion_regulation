function rsvp()
{
      /////////////////////////////
      ////// INITIALISATION //////
      ////////////////////////////

      var timelineTask = [];

      // Creation of Condition Matrix
      // Worth looking at the info on jsPsych.randomization.factorial


      [conditionRwd, condition] = createCondiMatrix(nbBlocksExp, nbTrialsExp);



      // var factors = {
      //       condiEmo: ['DC', 'CC', 'BC'],
      //       condiGender: ['Hom', 'Fem'],
      //       condiRwd: ['smallRwd', 'largeRwd']
      // };
      //
      // var full_design = jsPsych.randomization.factorial(factors, 1);
      // console.log(full_design)

      var DC_largeRwd = {
            type:'html-keyboard-response',
            stimulus: '<p> DC_largeRwd.</p>'+
            '<p> <strong> Press spacebar when you are ready to start!</strong></p>',
            choices: 32,
            data: {
                  test_part: 'DC_largeRwd',
                  blocknumber: 0,
            }
      };

      var startBreak = {
            type:'html-keyboard-response',
            stimulus: '<p> Now you are ready to start the experiment.</p>'+
            '<p> The mini-game comprises '+nbTrialsExp+' trials. </p>' +
            '<p> In total there are '+nbBlocksExp+' parts and you will be offered to take breaks in-between parts. </p>' +
            '<p> There is no time limit on your responses or on your ratings.</p>'+
            '<p> <strong> Press spacebar when you are ready to start!</strong></p>',
            choices: [32],
            data: {
                  test_part: 'startBreak',
                  blockNb: 0,
                  trialNb: 0,
            }
      };

      /////////////////////////////////
      ////// Start of the Block //////
      ////////////////////////////////

      for (var block = 0; block < nbBlocksExp; block++)  {

            var blockBreak = {
                  type:'html-keyboard-response',
                  stimulus:'<p> You can now pause for a break. You have completed '+block+' out of '+nbBlocksExp+' parts. </p>' +
                  '<p> <strong> Press spacebar when you are ready to continue!</strong></p>',
                  choices: [32],
                  data: {
                        test_part: 'blockbreak',
                        blockNb: block,
                        trialNb: 0,
                  }
            };

            //PUSH BREAK SCREENS BETWEEN EACH BLOCK
            if (block == 0){
                  timelineTask.push(startBreak);
            }
            else {
                  timelineTask.push(blockBreak);
            }

            // Put here the parameters that need to be randomised every block

            /////////////////////////////////
            ////// Start of the trial //////
            ////////////////////////////////

            for(var trial = 0; trial < nbTrialsExp; trial++){ /// use of let instead of var as it allows it to be used in function loops

                  for (var nbImg = 0; nbImg < setSize; nbImg++){
                        var rsvp = {
                              type: "image-keyboard-response",
                              //stimulus: rsvpFlux[nbImg],
                              stimulus: "instructions/instBC.jpg",
                              choices: jsPsych.NO_KEYS,
                              trial_duration: 70,
                              response_ends_trial: false,
                              data: {
                                    test_part: 'rsvp'+block+'image',
                                    blockNb: block,
                                    trialNb: trial,
                              },
                        };
                        timelineTask.push(rsvp);
                  }

                  var rsvpAnswFem = {
                        type:'html-keyboard-response',
                        stimulus:'<p> Avez-vous vu au moins une femme? </p>' +
                        '<p> <strong> Oui [O] / Non [N] </strong></p>',
                        choices: [37, 39], // left and right arrows
                        response_ends_trial: true, //If true, trial will end when subject makes a response.
                        data: {
                              test_part: 'rsvpAnswFem',
                              blockNb: block,
                              trialNb: trial,
                        },
                  };

                  var rsvpAnswHom = {
                        type:'html-keyboard-response',
                        stimulus:'<p> Avez-vous vu au moins un homme? </p>' +
                        '<p> <strong> Oui [O] / Non [N] </strong></p>',
                        choices: [37, 39],
                        response_ends_trial: true,
                        data: {
                              test_part: 'rsvpAnswHom',
                              blockNb: block,
                              trialNb: trial,
                        },
                  };

                  timelineTask.push(rsvpAnswFem);
                  timelineTask.push(rsvpAnswHom);
                  //timelineTask.push(fullscreenExp);
            } // End of the trial


      } // End of the blocks

      return timelineTask;
} // end of the function
