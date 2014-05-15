%Name - Umang Patel (ujp2001)
%  This is a function that calculates the GMM baseline.

%Input - Cell structure contianing audio features
%Output - GMM baeline scores

load('features.mat');


num_gauss=16; % <------- One can change the number og Gaussians Here



trainingindex=80; %<---- Vary the proportion to be extracted from each folder
endindex=100;
difference=endindex-trainingindex;

garraym=cell(difference,1,1);
garrayf=cell(difference,1,1);


mcounter=0;
fcounter=0;
for i=1:length(totalfeat)
    i
   temp= totalfeat{i,2}; 
         
   
          if(i==1)  
        
            for j=(trainingindex+1):endindex
       
       
                option=statset('MaxIter',500,'Display','iter') ;
                gi=gmdistribution.fit(temp{j,2},num_gauss,'CovType','diagonal','OPTIONS',option);
                
                grraym{mod(j,trainingindex)}=gi;
                
            end         
          end  
          
          
          if(i==4)  
        
            for j=(trainingindex+1):endindex
       
       
                option=statset('MaxIter',500,'Display','iter') ;
                gi=gmdistribution.fit(temp{j,2},num_gauss,'CovType','diagonal','OPTIONS',option);
                
                grrayf{mod(j,trainingindex)}=gi;
                
            end         
          end  
          
          if(i==2 || i==3)  
        
            for j=(trainingindex+1):endindex
                
                
                    postarray=[];
                for gg=1:length(garraym)
                    [post,NLOGL]=posterior(grraym{mod(j,trainingindex)},temp{j,2});
                    postarray=[postarray, NLOGL];
                     
                    
       
                end
                
                [max1,maxindex]=min(postarray);
                
                if (maxindex==mod(j,trainingindex))
                    mcounter=mcounter+1;
                end
                
            end         
          end
          
          
          
          
          if(i==5 || i==6)  
        
            for j=(trainingindex+1):endindex
                
                
                    postarray=[];
                for gg=1:length(garrayf)
                    [post,NLOGL]=posterior(grrayf{mod(j,trainingindex)},temp{j,2});
                    postarray=[postarray, NLOGL];
                     
                    
       
                end
                
                [max1,maxindex]=min(postarray);
                
                
                if (maxindex==mod(j,trainingindex))
                    fcounter=fcounter+1;
                end
                
            end         
          end
          
          
end


fprintf('\n Male speaker GMM accuracy %d \n',(mcounter/(2*difference))*100);

fprintf('\n Female speaker GMM accuracy %d \n',(fcounter/(2*difference))*100);

               