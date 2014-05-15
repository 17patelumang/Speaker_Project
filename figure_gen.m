%Name - Umang Patel (ujp2001)
%  This is a function that generates the figure on all the results
%  obtained.



figure
l=cell(1,4);
    l{1}='GMM';l{2}='d=30'; l{3}='d=40'; l{4}='d=168';

     h = bar([5,5,5,5;6,5,6,5;12.5,7.5,12.5,7.5;6,7,15,11]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('i-vectors with out applying LDA and HLDA')
   ylabel('Accuracy')
   xlabel('i-vector dimension and GMM Base Line')
   
 figure;  
   
l=cell(1,4);
    l{1}='GMM';l{2}='d=30'; l{3}='d=40'; l{4}='d=168';

     h = bar([5,5,5,5;5,17.5,2.5,10;5,15,12.5,10;7.5,10,17.5,12.5]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('i-vectors with  applying LDA and HLDA')
   ylabel('Accuracy')
   xlabel('i-vector dimension and GMM Base Line')   
   
   
  figure; 
   
   l=cell(1,3);
    l{1}='d=30'; l{2}='d=40'; l{3}='d=168';

     h = bar([8,7,8,7;15,11,15,11;9,9,9,9]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('Most frequenctly occuring speaker-id without using LDA and HLDA')
   ylabel('Speaker ID')
   xlabel('i-vector dimension')
   
   figure;
   
   l=cell(1,3);
    l{1}='d=30'; l{2}='d=40'; l{3}='d=168';

     h = bar([13,10,11,13;8,12,12,9;10,9,9,9]);
     set(gca,'xticklabel', l);
     legend('Male LDA','Female LDA','Male HLDA','Female HLDA')
   title('Most frequenctly occuring speaker-id with using LDA and HLDA')
   ylabel('Speaker ID')
   xlabel('i-vector dimension')