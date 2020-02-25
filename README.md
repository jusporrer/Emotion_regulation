# Effect of Incentive Motivation on Emotion Regulation  

This project carried at the ICM (France) aims to investigate the possible upregulating and downregulating effects of monetary incentives on the attentional regulation of emotionally negative stimuli.

## Step-by-step manual

### Processing and sorting of the face images
- Download the Chicago Face Database <https://chicagofaces.org/default/>
- Put the folder in the same folder as "emotion_regulation"
- Run the file "processingImgCFD.m" from the folder "CDF_processing". The current settings only select caucasian male and females which are not rated as more than three std from the mean in terms of unusuality, looking afraid or surprised (when doing a neutral expression).This results in 177 out of 597 people remaining, and 454 images.
- Run the file "processExpImg.m" from the folder "CDF_processing". This requires "Image Processing Toolbox" on Matlab. 
