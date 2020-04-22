function rsvp()
{
      /////////////////////////////
      ////// INITIALISATION //////
      ////////////////////////////

      var timelineTask = [];

      // Creation of Condition Matrix
      // Worth looking at the info on jsPsych.randomization.factorial


      [conditionRwd, condition] = createCondiMatrix(nbBlocksExp, nbTrialsExp);

      console.log(conditionRwd)
      console.log(condition)

      function randi(min, max) { // min and max included (acts like randi of Matlab)
        return Math.floor(Math.random() * (max - min + 1) + min);
      }

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

            for(var trial = 0; trial < nbTrialsExp; trial++){

              // Position of the Distractor and Target
              posCritDist = randi(4,8); // random number between 4 and 8
              posTarget = posCritDist + (Math.floor(Math.random()*2)+1) *2; // either 2 or 4

              // Select new images every trial W: white, F: female / M: male, F: fearful / N: neutral
              img = [imgWFF, imgWMF, imgWFN, imgWMN];
              scramble = [scrambleWFF, scrambleWMF, scrambleWFN, scrambleWMN];

              // Indexing of img (easier to randomise between)
              fem = [0,2]; male = [1,3]; fear = [0,1]; neutral = [2,3];

              if (condition[block][trial] == 1){ // DC_male: fearful male D, neutral fem & male T
                distractor = fear[1];
                target = neutral[randi(0,1)];

              } else if (condition[block][trial] == 2){ // DC_fem: fearful female D, neutral fem & male T
                distractor = fear[0];
                target = neutral[randi(0,1)];

              } else if (condition[block][trial] == 3){ // CC_male: neutral man D, neutral male or female T OR fearful man D, fearful male or female T
                distractor = male[randi(0,1)];
                if (distractor == male[0]){target = fear[randi(0,1)];}
                if (distractor == male[1]){target = neutral[randi(0,1)];}

              } else if (condition[block][trial] == 4){ // CC_female: neutral female D, neutral male or female T OR fearful female D, fearful male or female T
                distractor = fem[randi(0,1)];
                if (distractor == fem[0]){target = fear[randi(0,1)];}
                if (distractor == fem[1]){target = neutral[randi(0,1)];}

              } else if (condition[block][trial] == 5){ // BC_male: neutral male D, fearful male or female T
                distractor = neutral[1];
                target = fear[randi(0,1)];

              } else if (condition[block][trial] == 6){ // BC_fem : neutral female D, fearful male or female T
                distractor = neutral[0];
                target = fear[randi(0,1)];
              };

                  // First, fixation
                  timelineTask.push(fixation);

                  // The RSVP
                  for (var nbImg = 0; nbImg < setSize; nbImg++){
                    if (nbImg == posCritDist){
                      var rsvpFlux = img[distractor][randi(0,img[distractor].length)];
                    } else if (nbImg == posTarget){
                      var rsvpFlux = img[target][randi(0,img[target].length)];
                    } else {
                      var rsvpFlux = scramble[distractor][randi(0,img[distractor].length)];
                    };

                    var rsvp = {
                      type: "image-keyboard-response",
                      stimulus: rsvpFlux,
                      choices: jsPsych.NO_KEYS,
                      trial_duration: imageDuration,
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

                  if (condition[block][trial] == 1 || condition[block][trial] == 3 || condition[block][trial] == 5) {
                        timelineTask.push(rsvpAnswFem);
                  } else if (condition[block][trial] == 2 || condition[block][trial] == 4 || condition[block][trial] == 6) {
                        timelineTask.push(rsvpAnswHom);
                  };
                  //timelineTask.push(fullscreenExp);
            } // End of the trial


      } // End of the blocks

      return timelineTask;
} // end of the function
