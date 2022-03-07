%**********************************************************************

if     imflag==1
%----------------------------------------------------------------------
if     im==1                               % trapezium rule first order
  sm = (2/ts)*sma + smb + (1/2*ts)*smc;
  rh = rs + (2/ts)*sma*Tpt + sma * Tdpt - smc*sumv - (1/2*ts)*smc * Tpt;
elseif im==2                              % trapezium rule second order
  sm = (4/ts2)*sma + (2/ts)*smb + smc;
  rh = rs + (4/ts2*sma + 2/ts*smb)*Tpt + (4/ts*sma + smb)*Tdpt + sma*Tddpt;
elseif im==3                                                  % Newmark
  sm = (1/(Ga*ts2))*sma + (Gd/(Ga*ts))*smb + smc;
  rh = rs + ...
       ((1/(Ga*ts2))*sma + (Gd/(Ga*ts))*smb) * Tpt + ...
       ((1/(Ga*ts))*sma - (1-Gd/Ga)*smb) * Tdpt + ...
       ((1/Ga*(0.5 - Ga))*sma - ts*(1-Gd/(2*Ga))*smb) * Tddpt;
elseif im==4                                        % central diference
  sm = (1/ts2)*sma + (1/2*ts)*smb;
  rh = rs + ...
       ((2/ts2)*sma - smc) * Tpt + ...
       ((-1/ts2)*sma + (1/2*ts)*smb) * Tptt;
elseif im==5                                                  % Newmark
  sm = sma/(Ga*ts2) + Gd/(Ga*ts)*smb + smc;
  rh = rs + ...
       (sma/(Ga*ts2) + Gd/(Ga*ts)*smb) * Tpt + ...
       (sma/(Ga*ts) - (1-Gd/Ga)*smb) * Tdpt + ...
       ((0.5-Ga)/Ga*sma - ts*(1-Gd/(2*Ga))*smb) * Tddpt;	     
elseif im==6                                           % implicit Euler
  sm = sma/ts2 + smb/ts + smc;
  rh = rs + (sma/ts2 + smb/ts) * Tpt + (sma/ts) * Tdpt;
end;
%----------------------------------------------------------------------
elseif imflag==2
%----------------------------------------------------------------------
if im==1                                   % trapezium rule first order
  Tdp  = (2/ts)*(Tp - Tpt) - Tdpt;
  Tddp = (4/ts2)*(Tp - Tpt) - (4/ts)*Tdpt - Tddpt;
  sumv = sumv + (1/2*ts)*(Tpt + Tp);
elseif im==2                              % trapezium rule second order
  Tdp  = (2/ts)*(Tp - Tpt) - Tdpt;
  Tddp = (4/ts2)*(Tp - Tpt) - (4/ts)*Tdpt - Tddpt;
  dfi  = sma*Tddp + smb*Tdp + smc*Tp;
  sumv = sumv + (1/2*ts)*(Tpt + Tp);
elseif im==3                                                  % Newmark
  Tdp  = (Gd/(Ga*ts))*Tp - (Gd/(Ga*ts))*Tpt + ...
         (1-Gd/Ga)*Tdpt + ts*(1-Gd/(2*Ga))*Tddpt;
  Tddp = (1/(Ga*ts2))*(Tp - Tpt - Tdpt*ts) - 1/Ga*(1/2-Ga)*Tddpt;
%  Tdp   = Tdpt + (1-Gd)*ts*Tddpt + Gd*ts*Tddp;
  dfi  = sma*Tddp + smb*Tdp + smc*Tp;
  sumv = sumv + (1/2*ts)*(Tpt + Tp);
elseif im==4                                        % central diference
  Tdpt  = (1/2*ts)*(Tp - Tptt);
  Tddpt = (1/ts2)*(Tp - 2*Tpt + Tptt);
elseif im==5                                                  % Newmark
  Tddp  = (Tp - Tpt - Tdpt*ts)/(Ga*ts2) - (0.5-Ga)/Ga*Tddpt;  
%  Tdp   = Tdpt + (1-Gd)*ts*Tddpt + Gd*ts*Tddp;
  Tdp  = (Gd/(Ga*ts))*Tp - (Gd/(Ga*ts))*Tpt + ...
         (1-Gd/Ga)*Tdpt + ts*(1-Gd/(2*Ga))*Tddpt;
elseif im==6                                           % implicit Euler
  Tdp   = (Tp - Tpt)/ts;
  Tddp  = (Tdp - Tdpt)/ts;
end;
%----------------------------------------------------------------------
elseif imflag==3
%----------------------------------------------------------------------
if     im==1                               % trapezium rule first order
  ff = ((2/ts)*sma + smb + (1/2*ts)*smc) * Tp;
elseif im==2                              % trapezium rule second order
  ff = ((4/ts2)*sma + (2/ts)*smb + smc) * Tp;
elseif im==3                                                  % Newmark
  ff = ((1/(Ga*ts2))*sma + (Gd/(Ga*ts))*smb + smc) * Tp;
elseif im==4                                       % central difference
  ff = ((1/ts2)*sma + (1/2*ts)*smb) * Tp;
elseif im==5                                                  % Newmark
  ff = (sma/(Ga*ts2) + Gd/(Ga*ts)*smb) * Tp + fi;
elseif im==6                                           % implicit Euler
  ff = (sma/ts2 + smb/ts) * Tp + fi;
end;
%----------------------------------------------------------------------
end;

%**********************************************************************
