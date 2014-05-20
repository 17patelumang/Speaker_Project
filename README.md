
FUNDAMENTALS OF SPEAKER RECOGNITION :- UMANG PATEL (ujp2001)

PROJECT NAME :- SPEKAER IDENTIFICATION USING I-VECTORS
Contact ujp2001@columbia.edu 
------------------------
Command to run the DEMO:
features.m
final_run.m
------------------------


Dependencies required for this project to RUN:
------------------------
VOICEBOX : Speech Processing Toolbox for MATLAB
http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html

The files included are :
------------------------
features.m 													- To extract features from audio files.
ubm_train.m 												- To train the UBM model on training and enrolment data.
ubm.m														- To train the total Variability matrix V in "s=m +Vy"
LDA.m														- To run LDA
HLDA.m		                                                - To run HLDA
GMM_baseline.m							                    - To run GMM baseline
final_run.m													- To run the entire program (intenrally calls all the above mentioned file)
figure_gen.m   												- To generate all the figures
cofactor.m 													- To find cofactor of matrix (internally called by HLDA.m)
CDS.m 														- To compute the CDS

Main instructions:
------------------
features.m
	1)Before caling final_run.m call the features.m so that it will create appropriate feature matrix


final_run.m
	1) It calls the above mentioned files internally.
	2) Change the num_gauss(line 11 to change number of GMM models) ,d(line 13 to change the dimension of i-vectors),trainingindex(line 16 to specify the proportion of training features from each folder)
	3) Change the above mentioned parameers to get different results.
	
GMM_baseline.m
	1)After running final_run.m run GMM_baseline.m because it used 'g_ubm'(UBM Model Parameters).	
=======
FUNDAMENTALS OF SPEAKER RECOGNITION :- UMANG PATEL (ujp2001)

PROJECT NAME :- SPEKAER IDENTIFICATION USING I-VECTORS
Contact ujp2001@columbia.edu 
------------------------
Command to run the DEMO:
features.m
final_run.m
------------------------


Dependencies required for this project to RUN:
------------------------
VOICEBOX : Speech Processing Toolbox for MATLAB
http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html

The files included are :
------------------------
features.m 													- To extract features from audio files.
ubm_train.m 												- To train the UBM model on training and enrolment data.
ubm.m														- To train the total Variability matrix V in "s=m +Vy"
LDA.m														- To run LDA
HLDA.m		                                                - To run HLDA
GMM_baseline.m							                    - To run GMM baseline
final_run.m													- To run the entire program (intenrally calls all the above mentioned file)
figure_gen.m   												- To generate all the figures
cofactor.m 													- To find cofactor of matrix (internally called by HLDA.m)
CDS.m 														- To compute the CDS

Main instructions:
------------------
features.m
	1)Before caling final_run.m call the features.m so that it will create appropriate feature matrix


final_run.m
	1) It calls the above mentioned files internally.
	2) Change the num_gauss(line 11 to change number of GMM models) ,d(line 13 to change the dimension of i-vectors),trainingindex(line 16 to specify the proportion of training features from each folder)
	3) Change the above mentioned parameers to get different results.
	
