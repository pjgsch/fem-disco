%**********************************************************************

function [elda0,eldaB,eldaC,sumv] = eldata1(ne,eldata,lok,ndof,nndof,nenod);

%======================================================================
%  Initialisation of integration point data
%  elda0 :  initial element data 
%           (e,6:8)  = [C0 R0 L0];
%  eldaC :  current element data
%           (e,6:11) = [C R L 0 0 0];
%  eldaB :  begin (end) increment element data
%           (e,6:11) = [C R L 0 0 0]; 
%======================================================================


elda0 = zeros(ne,20);  
eldaB = zeros(ne,20);  
eldaC = zeros(ne,20);

sumv = zeros(ndof,1);   

for e=1:ne
%  P1 = eldata(e,3);
%  P2 = eldata(e,4);
%  P3 = eldata(e,5);
  P1 = eldata(e,5);
  P2 = eldata(e,6);
  P3 = eldata(e,7);

%  elty  = 1;%lok(e,1);
  elty  = eldata(e,3);
  elma  = eldata(e,4);

%  nndof = lok(e,2);
%  nenod = length(find(lok(e,:)>0))-2;
  nedof = nndof*nenod;

%  elda0(e,1:3) = [elty nenod nndof];
  elda0(e,1:4) = [elty elma nenod nndof];

  if elty==1 | elty==2
    C = P1; R = P2; L = P3;
    elda0(e,6:8)  = [C R L];
    eldaC(e,6:8)  = [C R L];
  elseif elty==3
    SS = P1; aa = P2; mm = P3; mma = eldata(e,8);
    elda0(e,6:9)  = [SS aa mm mma];
    eldaC(e,6:9)  = [SS aa mm mma];
  elseif elty==4
    J = P1; b = P2; k = P3;
    elda0(e,6:8)  = [J b k];
    eldaC(e,6:8)  = [J b k];
  end;

%  eldaB(e,6:11) = [0 0 0 0 0 0];
  

%  lokvg(e,1:3) = [ nndof*(lok(e,3)-1)+1 nndof*(lok(e,4)-1)+1 0];
%  if nenod==3, lokvg(e,3) = nndof*(lok(e,5)-1)+1; end;

end;


%**********************************************************************
