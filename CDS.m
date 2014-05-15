%Name - Umang Patel (ujp2001)
%  This is a function that CDS(Cosine Distance Measure). Here the first
%  input is a matrix against which i-vectors are to be compared.

%Input:-
%Amat       -matrix again which test vector is to be tested
%ivec       -testvector whose CDS is to be computed

%Output
%CDSindex  -index of the row whose CDS score is maimum with input vector

function [CDSindex]=CDS(Amat,ivec)

       %%% i vectors are assumed to be in rows 

    Arow=size(Amat,1);

    ivec_repmat=repmat(ivec,Arow,1);
    
    normivec = sqrt(sum(ivec_repmat.^ 2, 2));
    normA= sqrt(sum(Amat.^ 2, 2));
    
    deno=1./(normivec.*normA);
    
    numerator=sum(Amat.*ivec_repmat,2);

    CDS_array=numerator.*deno;
    
    
    [CDSnum,CDSindex]=max(CDS_array);
    
    %CDS_array
    
    

end