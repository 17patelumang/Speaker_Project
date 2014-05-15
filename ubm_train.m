%Name - Umang Patel (ujp2001)
%  This is a function that trains the UBM model.

%Input:- 
%num_gauss                      -Number of Gaussians for GMM model 
%d                              -Dimensions of i-vectors
%trainingindex                  -Index of files to be used for training
%totalfeat                      -Cell array containing extracted features


%OUTPUT:-
%feature_len                    -Length of the featute vector
%full_feat                      -Array containing all the extracted
%features(now in array format)
%m                              -UBM mean supervector
%ubmsigma                       -UBM stacked covariance matrix
%g_ubm                          -Gausisan Model object



function [feature_len,full_feat,m,ubmsigma,g_ubm]=ubm_train(num_gauss,d,trainingindex,totalfeat)



%%%% STACKING FEATURES FOR UBM %%%%%


full_feat=[];
for i=1:length(totalfeat)
    
    %if (i==1 || i==4)
        temp= totalfeat{i,2}; 
    
        for j=1:trainingindex
                full_feat=[full_feat ;temp{j,2}];
        end
    %end
end


feature_len=size(full_feat,2); % 12 here 


option=statset('MaxIter',500,'Display','iter','TolFun',0.01) ;
g_ubm=gmdistribution.fit(full_feat,num_gauss,'CovType','diagonal','OPTIONS',option);




%%% Stacking UBM 'm' %%%%%%%%%%%%%%%
m=[];
for i=1:num_gauss
    m=[m ; g_ubm.mu(i,:)' ]  ;
end

%%%%% Constructing UBM big Sigma matrix %%%%%
ubmsigma=[];

for i=1:num_gauss
   ubmsigma=blkdiag(ubmsigma,diag(g_ubm.Sigma(:,:,i)));
end


size(ubmsigma)
%%%%%%%%%%%%%%%%%%%%%

end