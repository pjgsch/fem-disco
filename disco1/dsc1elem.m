%**********************************************************************

function [ema,emb,emc] = elmat1(e,eldaC,elda0);

%  elty = elda0(e,1); nenod = elda0(e,2);
  elty = elda0(e,1); elma = elda0(e,2); nenod = elda0(e,3);

  if elty==1 | elty==2
    C = eldaC(e,6); R = eldaC(e,7); L = eldaC(e,8);

    A = 0; if L>0.0, A = 1/L; end;
    B = 0; if R>0.0, B = 1/R; end;

    ema = C * [ 1 -1 ; -1 1 ]; 
    emb = B * [ 1 -1 ; -1 1 ]; 
    emc = A * [ 1 -1 ; -1 1 ];   
  elseif elty==3
    SS = elda0(e,6); aa = elda0(e,7); mm = elda0(e,8); mma = elda0(e,9);
%    S = SS; Sa = SS/aa; Sm = SS/mm; Sam = SS/(aa*mm);

    ema = [ 0 0; 0 0 ];
    emc = [ 0 0; 0 0 ];

    if elma==1
    emb = [(SS/aa)/2 -SS/(aa*mma); SS (SS/mm)/2];
    elseif elma==2
    emb = [(SS/mm)/2 -SS*(1+1/mm); -SS*(1/mm-1/(aa*mma)) SS*(1+1/mm)];
    elseif elma==3
    emb = [(SS/aa)/2 (SS/aa)*(-1+1/mma); -SS-SS/aa -(SS/aa)*(-1+1/mma)];
    end;
  elseif elty==4
    J = eldaC(e,6); b = eldaC(e,7); k = eldaC(e,8);
    C = J; B = b; A = k;

    ema = C * [ 1 -1 ; -1 1 ]; 
    emb = B * [ 1 -1 ; -1 1 ]; 
    emc = A * [ 1 -1 ; -1 1 ];   
  end;


%**********************************************************************
