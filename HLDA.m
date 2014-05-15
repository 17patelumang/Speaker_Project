%Name - Umang Patel (ujp2001)
%  This is a function that calculated HLDA on the input i-vectors.

%Input:-
%difference                -Variable to calculate the remaining number of
%audio files to be used in testing.
%totalfeat                 -Cell structure containing audio files
%ar11                      -Array containing i-vector from male1 folder
%ar22                      -Array containing i-vector from male2 folder
%ar33                      -Array containing i-vector from male3 folder
%ar44                      -Array containing i-vector from female1 folder
%ar55                      -Array containing i-vector from female2 folder
%ar66                      -Array containing i-vector from female3 folder
%d                         -Dimension of i-vectors
%trainingsize              -Variable used to calculate all the total number





%Output:-
%W                         -Cell stoing W_j in the algorithm of computing
%HLDA
%T                         -Total Covariance Matrix
%A                         -Projects matrix for HLDA

function[W,T,A]=HLDA(difference,totalfeat,ar11,ar22,ar33,ar44,ar55,ar66,d,trainingindex)


tempar11=ar11(((trainingindex+1):100),:);
ar11=ar11((1:trainingindex),:);

tempar44=ar44(((trainingindex+1):100),:);
ar44=ar44((1:trainingindex),:);


%%%%%  This code assumes the number of male and female exampels are equal
%%%%%  else a bit code modification has to be made .

%%%%%%%%%%%%%%%%%%%%HLDA (need to change depending upon folders)%%%%%%%%%%%%%%%
class_mean_m1=(ar11+ar22+ar33)/3;  %N_i =3 number of folders of males
class_mean_f1=(ar44+ar55+ar66)/3;  %N_i =3 number of folders of females

malesize=size(class_mean_m1,1);      % number of classes of males 
femalesize=size(class_mean_f1,1);    % number of classes of females 

%complete_mean1=(sum(ar11+ar22+ar33+ar44+ar55+ar66))/(trainingindex);

complete_mean1= (sum(ar11+ar22+ar33+ar44+ar55+ar66)+sum(tempar11+tempar44))/((trainingindex*6)+(2*difference));


complete_repmat1=repmat(complete_mean1,size(class_mean_m1,1),1); %%% Producing the same matrix in rows

%%%%% For Wi  (Will change on folders)%%%%%%%%
ar1m1=ar11-class_mean_m1;
ar2m1=ar22-class_mean_m1;
ar3m1=ar33-class_mean_m1;
ar4m1=ar44-class_mean_f1;
ar5m1=ar55-class_mean_f1;
ar6m1=ar66-class_mean_f1;
W=cell(malesize+femalesize,1);  %<---------------- will change on number of examples 
%%%%%%%%%%%%%%%%%%%%%

%%%%%% T calculation %%%%%%%

ar1T1=ar11-complete_repmat1;
ar2T1=ar22-complete_repmat1;
ar3T1=ar33-complete_repmat1;
ar4T1=ar44-complete_repmat1;
ar5T1=ar55-complete_repmat1;
ar6T1=ar66-complete_repmat1;
T=0;

complete_repmat_temp=repmat(complete_mean1,difference,1); %%% Producing the same matrix in rows of temp


ar11mean=tempar11-complete_repmat_temp;
ar44mean=tempar44-complete_repmat_temp;

for i = 1:size(ar11mean,1)
    T=T+ar11mean(i,:)'*ar11mean(i,:);
    T=T+ar44mean(i,:)'*ar44mean(i,:);
    
end



for i = 1:size(class_mean_m1,1)
T=T+ar1T1(i,:)'*ar1T1(i,:);
T=T+ar2T1(i,:)'*ar2T1(i,:);
T=T+ar3T1(i,:)'*ar3T1(i,:);
T=T+ar4T1(i,:)'*ar4T1(i,:);
T=T+ar5T1(i,:)'*ar5T1(i,:);
T=T+ar6T1(i,:)'*ar6T1(i,:);
end
T=T/((trainingindex*6)+(2*difference)); %% <---------------- will change based on training examples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%% Wi calculation %%%%%%%
for i = 1:size(class_mean_m1,1)
    
    
    size(ar1m1(i,:)');
    
    %%% Wi changes as per number of folder %%%
    W{i,1}=ar1m1(i,:)'*ar1m1(i,:);  %N_i =3 
    W{i,1}=W{i,1}+ar2m1(i,:)'*ar2m1(i,:);  %N_i =3 
    W{i,1}=W{i,1}+ar3m1(i,:)'*ar3m1(i,:);  %N_i =3
    W{i,1}=W{i,1}/3; %N_i =3
    
    
    
    W{malesize+i,1}=ar4m1(i,:)'*ar4m1(i,:);  %N_i =3 
    W{malesize+i,1}=W{malesize+i,1}+ar5m1(i,:)'*ar5m1(i,:);  %N_i =3 
    W{malesize+i,1}=W{malesize+i,1}+ar6m1(i,:)'*ar6m1(i,:);  %N_i =3 
    W{malesize+i,1}=W{malesize+i,1}/3; %N_i =3
    %%% Wi changes as per number of folder %%%
    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%% BASIC ALGO impementation
A=eye(d);
Abar=A;
iter=20;
counter=1;

p=d ; %% d>p>r 

while(counter~=iter)
    
    temp=size(A,1);
    
    
    for i=1:temp %% iteration loop for rows
        
        Acoeff=cofactor(A);
        
        if(i<=p)
            
            for j=1:(malesize+femalesize) %%% Clusters
                
                Gr= (3/trainingindex)*W{j,1}/(A(i,:)*W{j,1}*A(i,:)');  %% Nj-3 , N-60
                
            end
            
            Gr=Gr*trainingindex;
            Gr=Gr/((trainingindex*6)+(2*difference));
            
        else
            
                Gr= T/(A(i,:)*T*A(i,:)');
        
        end
        
        alphar=1/abs(det(A));
        
        
        
        
        
        
        if(i<=p)
                
%              if(counter==1)
%                  beta=abs(det(Gr))^(1/d);
%                end

                beta=1;
              
             A(i,:)=(  inv(Gr+(beta*eye(d)))     *     ( (alphar*Acoeff(i,:)') +   ((beta*eye(d))*Abar(i,:)'/counter )));
             Abar(i,:)=Abar(i,:)+A(i,:);
            
        else
            
             A(i,:)=(inv(Gr)*alphar*Acoeff(i,:)')';
        
        end
        
        
    end
    
    
    counter=counter+1
end


end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

