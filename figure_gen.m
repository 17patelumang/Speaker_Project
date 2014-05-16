%Name - Umang Patel (ujp2001)
%  This is a function that generates the figure on all the results
%  obtained.



figure
l=cell(1,4);
    l{1}='GMM';l{2}='d=30'; l{3}='d=40'; l{4}='d=84';

     h = bar([70.5,67.5,70.5,67.5;60,50,60,50;65,65,65,65;52.5,42.5,52.5,42.5]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('i-vectors with out applying LDA and HLDA')
   ylabel('Accuracy')
   xlabel('i-vector dimension and GMM Base Line')
   
 figure;  
   
l=cell(1,4);
    l{1}='GMM';l{2}='d=30'; l{3}='d=40'; l{4}='d=84';

     h = bar([70.5,67.5,70.5,67.5;10,12.5,60,50;7.5,5,65,65;12.5,4,55,45]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('i-vectors with  applying LDA and HLDA')
   ylabel('Accuracy')
   xlabel('i-vector dimension and GMM Base Line')   
   
   
  figure; 
   
   l=cell(1,3);
    l{1}='d=30'; l{2}='d=40'; l{3}='d=84';

     h = bar([10,11,10,11;10,9,10,9;11,10,11,10]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('Most frequenctly occuring speaker-id without using LDA and HLDA')
   ylabel('Speaker ID')
   xlabel('i-vector dimension')
   
   figure;
   
   l=cell(1,3);
    l{1}='d=30'; l{2}='d=40'; l{3}='d=84';

     h = bar([7,10,10,11;8,14,10,10;9,9,11,11]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('Most frequenctly occuring speaker-id with using LDA and HLDA')
   ylabel('Speaker ID')
   xlabel('i-vector dimension')