%**********************************************************************

function [eldaC] = elprop1(e,eldaC,elda0,eldaB,lok,Tp);

elty = elda0(e,1);
elma = elda0(e,2);

if elty==2,          % diod
  DRL = elda0(e,7);  % diod resistance low
  n1  = lok(e,1);
  n2  = lok(e,2);
  DV  = Tp(n2)-Tp(n1);
  if DV <= 0 
    eldaC(e,7) = DRL;
%    eldaC(e,2) = DRL + 1e3*DRL*( 1 + atan(DV/1)/(pi/2) );
  else
    eldaC(e,7) = 1e6*DRL;
%    eldaC(e,2) = DRL + 1e6*DRL*( 1 + atan(DV/1000)/(pi/2) );
  end;
end;


%**********************************************************************
