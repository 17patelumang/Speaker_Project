%Name - Umang Patel (ujp2001)
% This is a matlab file that runs the entire program.
% Uncommenting line 111-123 appropriately will allow the user to use
% i-vectors are it is or apply LDA and HLDA on it .



load('features.mat');


num_gauss=16;

d=30; % dimension of i-vector


trainingindex=80; %%%% to take forst from each folder for training (means 80% training data)


disp('Running ubm_train.......')
[feature_len,full_feat,m,ubmsigma,g_ubm]=ubm_train(num_gauss,d,trainingindex,totalfeat);
mubm=m;





endindex=100; % end parameter in features.m file
trainingsize=6*trainingindex; %(Multiplying by 6 because there are 6 flders)
trainingindex=80;
difference=endindex-trainingindex;


disp('Running ubm.......')
[S_MU,I_VEC,NS,FS,AC,FFS,SC,NNS,LVS,YS,SSS,FS_C,SC_C,C,NN,sigma_SSS,vtrain,ar1,ar2,ar3,ar4,ar5,ar6,i_vec_array]=ubm(difference,trainingsize,trainingindex,g_ubm,d,num_gauss,feature_len,mubm,full_feat,totalfeat,ubmsigma);


disp('Running LDA.......')
[covara,covar11,Sb1,Sw1,Avec1]=LDA(difference,totalfeat,ar1,ar2,ar3,ar4,ar5,ar6,trainingindex);



disp('Running HLDA.......')
[W,hldaThlda,Ahlda]=HLDA(difference,totalfeat,ar1,ar2,ar3,ar4,ar5,ar6,d,trainingindex);


enrollmentindexfolder=1; % enrollement index ; automatically in femmale 1st folder be used for enrollemnt and remainind for testing ;

enrollemnt_male_ivectors=[]; % each row will be i-vector
enrollemnt_female_ivectors=[];

test_male_ivectors=[];
test_female_ivectors=[];

disp('Extracting test and enrollment i-vectors')

for i=1:length(totalfeat)
    i
   temp= totalfeat{i,2}; 
         
   
    
        
            for j=(trainingindex+1):endindex
       
       
                option=statset('MaxIter',500,'Display','iter','TolFun',0.01) ;
                gi=gmdistribution.fit(temp{j,2},num_gauss,'Start',struct('mu',g_ubm.mu,'Sigma',g_ubm.Sigma,'PComponents',g_ubm.PComponents),'CovType','diagonal','Regularize',0.1,'OPTIONS',option);
       
                %%%%%% CALCULATING s_i in "s_i = m + Tw_i "%%%%%%%%%%%%%%
                m_temp=[];
                        
                for ii=1:num_gauss
                    m_temp=[m_temp ; gi.mu(ii,:)' ]  ;
                end
                
                
                if (i==enrollmentindexfolder ) % 3 number of folders of males each
                
                    
                    
                    enrollemnt_male_ivectors=[enrollemnt_male_ivectors ; (pinv(vtrain)*(m_temp-mubm))'];
                    
                  
                
                elseif (i==(enrollmentindexfolder+3))
                    
                    enrollemnt_female_ivectors=[enrollemnt_female_ivectors ; (pinv(vtrain)*(m_temp-mubm))'];
                    
                elseif(i<=3)
                    
                    test_male_ivectors=[test_male_ivectors ; (pinv(vtrain)*(m_temp-mubm))'];
                    
                else
                    
                    test_female_ivectors=[test_female_ivectors ; (pinv(vtrain)*(m_temp-mubm))'];
                    
                end
                
            end
       
   
   
        
end


size(enrollemnt_male_ivectors)
size(enrollemnt_female_ivectors)
size(test_male_ivectors)
size(test_female_ivectors)

%%% Uncommenting line 111-123 appropriately will allow the user to use
%%% i-vectors are it is or apply LDA and HLDA on it .

lda_male_enrollment=(Avec1'*enrollemnt_male_ivectors')';
lda_female_enrollment=(Avec1'*enrollemnt_female_ivectors')';


hlda_male_enrollment=(Ahlda'*enrollemnt_male_ivectors')';
hlda_female_enrollment=(Ahlda'*enrollemnt_female_ivectors')';

% lda_male_enrollment=(enrollemnt_male_ivectors')';
% lda_female_enrollment=(enrollemnt_female_ivectors')';
% 
% 
% hlda_male_enrollment=(enrollemnt_male_ivectors')';
% hlda_female_enrollment=(enrollemnt_female_ivectors')';


%%%%% MALE LDA %%%%%%%%%

enrollsize=size(enrollemnt_male_ivectors,1);
testsize=size(test_male_ivectors,1);


malelda=0;
mindex=[];
for(k=1:testsize)
    
    index= CDS(lda_male_enrollment,test_male_ivectors(k,:));
    
    mindex=[mindex ,index];
    
    if(mod(k,enrollsize)~=0 && index==mod(k,enrollsize))
        
        malelda=malelda+1;
        
    elseif( mod(k,enrollsize)==0 && index==(mod(k,enrollsize)+1) )
        
        malelda=malelda+1;
        
    end
    
end

fprintf('\n Male speaker LDA accuracy %d \n',(malelda/testsize)*100);
mindex=[mindex ,0 ]
fprintf('\n Most Frequently Occuring Male speaker LDA index %d \n',median(mindex));

%%%%% FEMALE LDA %%%%%%%%%

enrollsize=size(enrollemnt_female_ivectors,1);
testsize=size(test_female_ivectors,1);


femalelda=0;
findex=[];
for(k=1:testsize)
    
    index= CDS(lda_female_enrollment,test_female_ivectors(k,:));
    
    findex=[findex ,index];
    
    if(mod(k,enrollsize)~=0 && index==mod(k,enrollsize))
        
        femalelda=femalelda+1;
        
    elseif( mod(k,enrollsize)==0 && index==(mod(k,enrollsize)+1) )
        
        femalelda=femalelda+1;
        
    end
    
end

fprintf('\n Female speaker LDA accuracy %d \n',(femalelda/testsize)*100);
findex=[findex,0]
fprintf('\n Most Frequently Occuring Female speaker LDA index %d \n',median(findex));

%%%%% MALE HLDA %%%%%%%%%

enrollsize=size(enrollemnt_male_ivectors,1);
testsize=size(test_male_ivectors,1);


malehlda=0;
mindex=[];
for(k=1:testsize)
    
    index= CDS(hlda_male_enrollment,test_male_ivectors(k,:));
    
    mindex=[mindex ,index];
    
    if(mod(k,enrollsize)~=0 && index==mod(k,enrollsize))
        
        malehlda=malehlda+1;
        
    elseif( mod(k,enrollsize)==0 && index==(mod(k,enrollsize)+1) )
        
        malehlda=malehlda+1;
        
    end
    
end

fprintf('\n Male speaker HLDA accuracy %d \n',(malehlda/testsize)*100);
mindex=[mindex , 0 ]
fprintf('\n Most Frequently Occuring Male speaker HLDA index %d \n',median(mindex));



%%%%% FEMALE HLDA %%%%%%%%%

enrollsize=size(enrollemnt_female_ivectors,1);
testsize=size(test_female_ivectors,1);


femalehlda=0;
findex=[];
for(k=1:testsize)
    
    index= CDS(hlda_female_enrollment,test_female_ivectors(k,:));
    
    findex=[findex ,index];
    
    if(mod(k,enrollsize)~=0 && index==mod(k,enrollsize))
        
        femalehlda=femalehlda+1;
        
    elseif( mod(k,enrollsize)==0 && index==(mod(k,enrollsize)+1) )
        
        femalehlda=femalehlda+1;
        
    end
    
end

fprintf('\n Female speaker HLDA accuracy %d \n',(femalehlda/testsize)*100);
findex=[findex ,0]
fprintf('\n Most Frequently Occuring Female speaker HLDA index %d \n',median(findex));
