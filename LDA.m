%Name - Umang Patel (ujp2001)
%  This is a function that calculated LDA on the input i-vectors.


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
%trainingsize              -Variable used to calculate all the total number





%Output:-
%covara                   -Intra Class Covariance before applying LDA
%covara11                 -Intra Class Covariance after applying LDA
%Sb1                      -Inter Class Covariance Matrix
%Sw1                      -Intra Class Covariance Matrix
%Avec1                    -EigenVectors of Multiplication of inv(Sw1)*Sb1


function[covara,covar11,Sb1,Sw1,Avec1]=LDA(difference,totalfeat,ar11,ar22,ar33,ar44,ar55,ar66,trainingindex)

tempar11=ar11(((trainingindex+1):100),:);
ar11=ar11((1:trainingindex),:);

tempar44=ar44(((trainingindex+1):100),:);
ar44=ar44((1:trainingindex),:);

%%%%%%%%%%%%%%%%%%%%LDA (need to change depending upon folders)%%%%%%%%%%%%%%%
class_mean_m1=(ar11+ar22+ar33)/3;  %N_i =3 number of folders of males
class_mean_f1=(ar44+ar55+ar66)/3;  %N_i =3 number of folders of females

%complete_mean1=(sum(ar11+ar22+ar33+ar44+ar55+ar66))/(trainingindex);

complete_mean1= (sum(ar11+ar22+ar33+ar44+ar55+ar66)+sum(tempar11+tempar44))/((trainingindex*6)+(2*difference));
complete_repmat1=repmat(complete_mean1,size(class_mean_m1,1),1); %%% Producing the same matrix in rows

%%%%% For Sw  (Will change on folders)%%%%%%%%
ar1m1=ar11-class_mean_m1;
ar2m1=ar22-class_mean_m1;
ar3m1=ar33-class_mean_m1;
ar4m1=ar44-class_mean_f1;
ar5m1=ar55-class_mean_f1;
ar6m1=ar66-class_mean_f1;
Sw1=0;
%%%%%%%%%%%%%%%%%%%%%

%%% For Sb %%%%%%
a1= class_mean_m1-complete_repmat1;
b1= class_mean_f1-complete_repmat1;


complete_repmat_temp=repmat(complete_mean1,difference,1); %%% Producing the same matrix in rows of temp


ar11mean=tempar11-complete_repmat_temp;
ar44mean=tempar44-complete_repmat_temp;

Sb1=0;


for i = 1:size(ar11mean,1)
    Sb1=Sb1+ar11mean(i,:)'*ar11mean(i,:);
    Sb1=Sb1+ar44mean(i,:)'*ar44mean(i,:);
    
end

%%%%%%%%%%%%%%%%

for i = 1:size(class_mean_m1,1)
    
    Sb1=Sb1+3*a1(i,:)'*a1(i,:);  %N_i =3  
    Sb1=Sb1+3*b1(i,:)'*b1(i,:);  %N_i =3
    
    %%% Sw changes as per number of folder %%%
    Sw1=Sw1+ar1m1(i,:)'*ar1m1(i,:);  %N_i =3 
    Sw1=Sw1+ar2m1(i,:)'*ar2m1(i,:);  %N_i =3 
    Sw1=Sw1+ar3m1(i,:)'*ar3m1(i,:);  %N_i =3 
    Sw1=Sw1+ar4m1(i,:)'*ar4m1(i,:);  %N_i =3 
    Sw1=Sw1+ar5m1(i,:)'*ar5m1(i,:);  %N_i =3 
    Sw1=Sw1+ar6m1(i,:)'*ar6m1(i,:);  %N_i =3 
    %%% Sw changes as per number of folder %%%
    
    
end



[Avec1 Aval1]=eig(inv(Sw1)*Sb1);

i_vec_array_inside=[ar11;ar22;ar33;ar44;ar55;ar66];

i_vec_array_inside=(Avec1'*i_vec_array_inside')';
                    
                    covara=[];
                    covar11=[];
                %%% For plotting sake %%%%%
                    for i=1:10
                       covara=[covara , norm(var([ar11(i,:);ar22(i,:);ar33(i,:)]))];
                       covar11=[covar11 , norm(var([i_vec_array_inside(i,:);i_vec_array_inside(10+i,:);i_vec_array_inside(20+i,:)]))];
                        
                    end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%