%**********************************************************************

function [nrm] = cnvnrm1(p,pt,rs,pu,nm);

if nm==1
%  mx  = max(abs(p-pt)); if mx<=1e-10 , mx = 1; end;
%  nrm = ((p-pt)'*(p-pt))/mx;
  mx  = max(abs(p)); if mx<=1e-10 , mx = 1; end;
%  mx = 1;
  nrm = ((p(pu))'*(p(pu)))/mx;
  %nrm = max(abs(rs(pu)));
  %nrm = sqrt(rs(pu)'*rs(pu))/max(abs(rs(pu)));
  %nrm = sqrt(rs(pu)'*rs(pu))/max(abs(rs));
elseif nm==2
  %mx  = max(abs(p)); if mx<=1e-10 , mx = 1; end;
  mx  = max(abs(rs(pu))); if mx<=1e-20 , mx = 1; end;
  %nrm = (p'*p)/mx;
  %nrm = max(abs(rs(pu)))/mx;
  nrm = sqrt(rs(pu)'*rs(pu))/mx;
elseif nm==3
  nrm = sqrt((pt-p)'*(pt-p));
end;

%**********************************************************************
