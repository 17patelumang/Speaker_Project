%Name - Umang Patel (ujp2001)

%  This file extacts features from audio files and keeps them is stack .
%  Keep this file in the same location as Folders containing audios files .
%  Eg:- In the case keep run this file by keeping it at the location of
%  folder male  and femlae.

%Input:- Folder containing audio files
%OUTPUT:- Cell structure (totalfeat) containing extracted features and stores in totalfeat.mat file.



clear all ;
gender = {'male','female'};
totalfeat = cell(6,2);
for i=1:2
    for j=1:3
        pathname = strcat(gender{i},'/',gender{i},num2str(j),'/');
        Files=dir(strcat(pathname,'*.wav'));
        totalfeat{(i-1)*3+j,1} = strcat(gender{i},num2str(j));
        feat = cell(100,2);
        
        for k=1:100
            k
            
           FileNames=Files(k).name;
           feat{k,1}=FileNames;
           
           temp=melcepst(readwav(char(strcat(pathname,FileNames))),8000,'dD',12);
           
           
           temp=[temp(:,1:12),temp(:,13:18),temp(:,19:21)];
           
           feat{k,2}=temp((1:floor(size(temp,1)/5)),:);
        end
        totalfeat{(i-1)*3+j,2} = feat;
    end
end
save('features.mat','totalfeat','-v7.3');