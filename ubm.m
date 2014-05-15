%Name - Umang Patel (ujp2001)
%  This is a function that trains matrix V(the total variability matrix).


%Input:-
%difference                -Variable to calculate the remaining number of
%audio files to be used in testing.
%trainingsize              -Variable used to calculate all the total number
%of audio files to be used as training in all 6 folders
%trainingindex             -Variable used to specify number of audio files
%per folder to be used in training.
%g_ubm                     -Training UBM model object
%d                         -Dimension of i-vectors
%num_gauss                 -Number of Gaussian Model to be used in UBM
%model
%feature_len               -Length of the extracted feature vector
%m                         -UBM mean super vector
%full_feat                 -Array containing featues extracted from audio
%files
%totalfeat                 -Cell structure containing audio files
%ubmsigma                  -The covairance matrix obtained from UBM



%Output:-
%S_MU                     -Cell containing extracted s_i in s_i=m+Vw_i
%I_VEC                    -Cell containing i-vectors
%NS                       -Cell (Equivalent to N_c(s) in the training of V (Total Variability Matrix)in step1)
%FS                       -Cell (Equivalent to F_c(s) in the training of V (Total Variability Matrix)in step1)
%AC                       -Cell (Equivalent to A_c in the training of V (Total Variability Matrix)in step5)
%FFS                      -Cell (Equivalent to FF(s) in the training of V (Total Variability Matrix)in step3)
%SC                       -Cell (Equivalent to S_c(s) in the training of V (Total Variability Matrix)in step1)
%NNS                      -Cell (Equivalent to NN(s) in the training of V (Total Variability Matrix)in step3)
%LVS                      -Cell (Equivalent to l_v(s) in the training of V (Total Variability Matrix)in step4)
%YS                       -Cell (Equivalent to y(cap)(s) in the training of V (Total Variability Matrix)in step4)
%SSS                      -Cell (Equivalent to SS(s) in the training of V (Total Variability Matrix)in step3)
%FS_C                     -Cell (Equivalent to F(cap)_c(s) in the training of V (Total Variability Matrix)in step2)
%SC_C                     -Cell (Equivalent to S(cap)_c in the training of V (Total Variability Matrix)in step2)
%C                        -Cell (Equivalent to C in the training of V (Total Variability Matrix)in step5)
%NN                       -Cell (Equivalent to NN in the training of V (Total Variability Matrix)in step5)
%sigma_SSS                -Cell (To store summation SS(s) in the training of V (Total Variability Matrix)(it is an optional step to change sigma))
%v                        -V Total Variability Matrix
%ar1                      -Array containing i-vector from male1 folder
%ar2                      -Array containing i-vector from male2 folder
%ar3                      -Array containing i-vector from male3 folder
%ar4                      -Array containing i-vector from female1 folder
%ar5                      -Array containing i-vector from female2 folder
%ar6                      -Array containing i-vector from female3 folder
%i_vec_array              -Array containing all the i-vectors

function [S_MU,I_VEC,NS,FS,AC,FFS,SC,NNS,LVS,YS,SSS,FS_C,SC_C,C,NN,sigma_SSS,v,ar1,ar2,ar3,ar4,ar5,ar6,i_vec_array]=ubm(difference,trainingsize,trainingindex,g_ubm,d,num_gauss,feature_len,m,full_feat,totalfeat,ubmsigma)
tic;




%%% Initilizing v %%%%
v=rand(feature_len*num_gauss,d);
iteration=20;
%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%% 'T' calculation %%%%%%%%%%%%%%%
S_MU=cell(trainingsize+(2*difference),2+1,1); % AS the number of exaples DO NOT change change this
I_VEC=cell(trainingsize+(2*difference),2+1,1); % AS the number of exaples DO NOT change change this
NS=cell(trainingsize+(2*difference),2+num_gauss,1); % AS the number of exaples change change this
FS=cell(trainingsize+(2*difference),2+num_gauss,1); % AS the number of exaples change change this
AC=cell(1,num_gauss,1); % AS the number of exaples DO NOT change change this
FFS=cell(trainingsize+(2*difference),2+1,1); % AS the number of exaples change change this
SC=cell(trainingsize+(2*difference),2+num_gauss,1); % AS the number of exaples change change this (storing each speaker component as vector of diagnol elements)
NNS=cell(trainingsize+(2*difference),2+1,1); % AS the number of exaples change change this
LVS=cell(trainingsize+(2*difference),2+1,1); % AS the number of exaples change change this
YS=cell(trainingsize+(2*difference),2+1,1); % AS the number of exaples change change this
SSS=cell(trainingsize+(2*difference),2+1,1); % AS the number of exaples change change this
FS_C=cell(trainingsize+(2*difference),2+num_gauss,1); % AS the number of exaples change change this
SC_C=cell(trainingsize+(2*difference),2+num_gauss,1); % AS the number of exaples change change this (storing each speaker component as vector of diagnol elements)
counter=1;

for i=1:length(totalfeat)
    i
   temp= totalfeat{i,2}; 
         
   if(i==1 || i==4) % need to change if folders change 
       newtrainingindex=100;
   else
       newtrainingindex=trainingindex;
   end
   
    
   for j=1:newtrainingindex
       j
       NS{counter,1}= temp{j,1};
       NS{counter,2}=i;
       
       FS{counter,1}= temp{j,1};
       FS{counter,2}=i;
       
       SC{counter,1}= temp{j,1};
       SC{counter,2}=i;
       
       S_MU{counter,1}= temp{j,1};
       S_MU{counter,2}=i;
       
       NNS{counter,1}= temp{j,1};
       NNS{counter,2}=i;
       
       FFS{counter,1}= temp{j,1};
       FFS{counter,2}=i;
       
       SSS{counter,1}= temp{j,1};
       SSS{counter,2}=i;
       
       FS_C{counter,1}= temp{j,1};
       FS_C{counter,2}=i;
       
       SC_C{counter,1}= temp{j,1};
       SC_C{counter,2}=i;
       
       option=statset('MaxIter',500,'Display','iter','TolFun',0.01) ;
       g=gmdistribution.fit(temp{j,2},num_gauss,'CovType','diagonal','OPTIONS',option);
       
       %%%%%% CALCULATING s_i in "s_i = m + Tw_i "%%%%%%%%%%%%%%
        m_temp=[];
        for ii=1:num_gauss
            m_temp=[m_temp ; g.mu(ii,:)' ]  ;
        end
       S_MU{counter,3}=m_temp;
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       temp0=posterior(g,temp{j,2});
       temp1=sum(temp0);
       
       
       %%%% CALCULATING NS && NNS %%%%%%%
        nns_vector=[];
       
       for k=1:length(temp1)
           
           NS{counter,2+k}=temp1(k);
           
           %%%% for NNS %%
           nns_vector=[ nns_vector , (temp1(k)*ones(1,feature_len)) ];
           %%%%%%%%%%%%%%%
           
       end
       
       
       %%%% NNS %%%%%
       NNS{counter,3}=diag(nns_vector);
       %%%%%%%%%%%%%
       
       %%%%%%%%%%%%%%%%%%%%%%%%%%%
       
       
       %%%%%% CALCULATING FS && FFS %%%%%%%
       
       ffs_vector=[];
       prod=temp0'*temp{j,2};
       
       for z=1:size(prod,1)
            FS{counter,2+z}=prod(z,:)';
            
            %%% CALCULATING FS-CAP%%%%
            
             FS_C{counter,2+z}=FS{counter,2+z}-(temp1(z)*g_ubm.mu(z,:)');  %here temp1(z)=N_c(s)
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%% FFS calculation %%%%
            ffs_vector=[ffs_vector ; FS_C{counter,2+z}];
            %%%%%%%%%%%%%%%%%%%%
            
       end
       
   
       %%%% FFS %%%%%%
       FFS{counter,3}=ffs_vector;
       %%%%%%%%%%%%%%
       
       
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
       
       
       
       %%%% CALCULATING SC  & SSS %%%%%%%
       sss_vector=[];
       
       for cc=1:num_gauss
           
           t.sum=zeros(feature_len,feature_len); % initializing 12*12 matrix for each component 
           
            for l=1:size(temp{j,2},1)
                Yt=temp{j,2}(l,:)';    % taking Yt as 12*1 vector
                t.sum=t.sum+temp0(l,cc)*Yt*Yt';
           
            end
            
            t.sum=diag(t.sum);
                
                
            t.vector=[];
            for m=1:length(diag(t.sum))
                
                t.vector=[t.vector ,t.sum(m)];
                
            end
            SC{counter,2+cc}=t.vector;
            
            
            %%%%% CALCULATING SC_CAP %%%%%%%  (m_c*=g_ubm.mu(cc,:))
            temp_sc=(FS{counter,2+cc}*g_ubm.mu(cc,:)) + (g_ubm.mu(cc,:)'*FS{counter,2+cc}')- (temp1(cc)*g_ubm.mu(cc,:)'*g_ubm.mu(cc,:));
            SC_C{counter,2+cc}=diag(  diag(SC{counter,2+cc}) - diag(diag(temp_sc)) );
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%% SSS calculation %%%%%%
            sss_vector=[sss_vector ;  (SC_C{counter,2+cc}) ];
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
       end
       
       
            %%%%% SSS %%%%%%
            SSS{counter,3}=diag(sss_vector);
            %%%%%%%%%%%%%%
       
       %%%%%%%%%%%%%%%%%%%%%%%%%%%
       
       
       
     
       counter=counter+1;
   end
end

%%%%% AC INITILIZATION %%%

for k=1:num_gauss
 AC{1,k}= zeros(d,d);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%


it_count=0;

%%%%% C initilization %%%%%
C=zeros(num_gauss*feature_len,d);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% NN & sigma_SSS initilization %%%%
NN=zeros(num_gauss*feature_len,num_gauss*feature_len);
sigma_SSS=zeros(num_gauss*feature_len,num_gauss*feature_len);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while(it_count~=iteration)
        counter=1;
        for i=1:length(totalfeat)
          
            temp= totalfeat{i,2}; 
         
                    if(i==1 || i==4) % need to change if folders change 
                        newtrainingindex=100;
                    else
                        newtrainingindex=trainingindex;
                    end
    
                    for j=1:newtrainingindex
                       
                        LVS{counter,1}= temp{j,1};
                        LVS{counter,2}=i;
                        
                        YS{counter,1}= temp{j,1};
                        YS{counter,2}=i;
                        
                        
                        
                        LVS{counter,3}=((eye(d,d))+(v'*inv(ubmsigma)*NNS{counter,3}*v));
                        YS{counter,3}=(inv(LVS{counter,3})*v'*inv(ubmsigma)*FFS{counter,3});
                        
                        
                        %%%%%%%%%%%%%% AC %%%%%%%%%
                        temp_inv=inv(LVS{counter,3});
                        for k=1:num_gauss
                            AC{1,k}= AC{1,k}+(NS{counter,2+k}*temp_inv);
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%
                        C=C+(FFS{counter,3}*(inv(LVS{counter,3})*v'*inv(ubmsigma)*FFS{counter,3})');
                       
                        
                        NN=NN+NNS{counter,3};
                        sigma_SSS=sigma_SSS+SSS{counter,3};
                        
                        counter=counter+1
                    end 
        end
        
        
        for m=1:num_gauss
            v(((feature_len*(m-1))+1):(feature_len*m),:)=C(((feature_len*(m-1))+1):(feature_len*m),:)*inv(AC{1,m});
        end
        
     
        %ubmsigma=inv(NN)*( sigma_SSS -diag(diag(C*v')));
        
it_count=it_count+1
end

size(v)
size(ubmsigma)

%%%%% CALCUlating i-vectors %%%%%
temp_counter=1;

%%%%%%%%%% ARRAY NUMBER EQUAL TO NUMBER OF FOLDERS %%%%%%%%%%%
ar1=[];
ar2=[];
ar3=[];
ar4=[];
ar5=[];
ar6=[];




for i=1:length(totalfeat)
    i
   temp= totalfeat{i,2}; 
   %     ar=[];
    %    mag=[] ;
   
    if(i==1 || i==4) % need to change if folders change 
       newtrainingindex=100;
   else
       newtrainingindex=trainingindex;
   end
    
   for j=1:newtrainingindex
       j
       
       I_VEC{temp_counter,1}= temp{j,1};
       I_VEC{temp_counter,2}=i;
       I_VEC{temp_counter,3}=pinv(v)*(S_MU{temp_counter,3}-m);
       
          
       if(i==1)
           ar1=[ar1 ;I_VEC{temp_counter,3}' ];
       elseif(i==2)
           ar2=[ar2 ;I_VEC{temp_counter,3}' ];
       elseif(i==3)
           ar3=[ar3 ;I_VEC{temp_counter,3}' ];
       elseif(i==4)
           ar4=[ar4 ;I_VEC{temp_counter,3}' ];
       elseif(i==5)
           ar5=[ar5 ;I_VEC{temp_counter,3}' ];
       elseif(i==6)
           ar6=[ar6 ;I_VEC{temp_counter,3}' ];
       end
       
       
       temp_counter=temp_counter+1;
       
       
       
   end
   
 % scatter(ar,mag)
   
end
       


%%%%%%%% IVECTOR ARRAY %%%%%%%%%%%%%%
i_vec_array=[ar1;ar2;ar3;ar4;ar5;ar6];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


toc;
end