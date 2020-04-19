function createCondiMatrix(nbBlocks, nbTrials)
{
      let conditionRwd = [[1,1],[1,2],[2,1],[2,2]];
      conditionRwd = jsPsych.randomization.repeat(conditionRwd, nbBlocks/4);
      conditionRwd = jsPsych.randomization.shuffleNoRepeats(conditionRwd);

      let condition = []; let condiDC = []; let condiCC = []; let condiBC = [];
      for (let i = 0; i < nbBlocks; i++) {

            condiCC = Array(nbTrials/6).fill([3,4]).flat(); // acts like repmat in Matlab (but less good haha)
            condiDC = condiCC.concat(Array(nbTrials/3).fill([1,2]).flat());
            condiBC = condiCC.concat(Array(nbTrials/3).fill([5,6]).flat());

            condiDC = jsPsych.randomization.shuffle(condiDC);
            condiBC = jsPsych.randomization.shuffle(condiBC);

            if (conditionRwd[i][1] == 1) {
                  condition[i] = condiDC;
            } else if (conditionRwd[i][1] == 2) {
                  condition[i] = condiBC;
            };
      };
      return [conditionRwd, condition];
} // end function
