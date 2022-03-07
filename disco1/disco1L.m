%**********************************************************************
% disco1L : discrete system computation : 1-dimensional, linear
%======================================================================
dsc1chkinp;                                              % dsc1chkinp.m
fbiblcase;                                                % fbiblcase.m
dsc1inizer;                                              % dsc1inizer.m
[elda0,eldaB,eldaC,sumv] = ...                           % dsc1inidat.m
                           dsc1inidat(nel,eldata,lok,ndof,nndof,nenod);
                                                      
save([matf num2str(0)]);
%======================================================================
% Incremental calculation
%======================================================================
ic = 1; ti = 0; ts2 = ts*ts;

while ic<=nic
%----------------------------------------------------------------------
Tpe = zeros(ndof,1); Ipe = zeros(ndof,1); Dfe = zeros(ndof,1);
ti = ti + ts; loadincr; 
dfe = (2/ts)*(fe - fet) - dfet; 
if     li=='ip', Ipe = pe; Tpe = Tpet + Ipe; Dpe = Ipe;  
elseif li=='tp', Tpe = pe; Ipe = Tpe - Tpet; Dpe = Ipe; end;
pe = Tpe; if im==1, rs = fe; else rs = dfe; end;
%sumv0 = sumv;
%======================================================================
% System matrices are assembled from element matrices
%======================================================================
if (ic==1 | nl==1)
%----------------------------------------------------------------------
smc=zeros(ndof); smb=zeros(ndof); sma=zeros(ndof);

for e=1:nel
  [ema,emb,emc] = dsc1elem(e,eldaC,elda0);                 % dsc1elem.m
  sma(lokvg(e,:),lokvg(e,:)) = sma(lokvg(e,:),lokvg(e,:)) + ema;
  smb(lokvg(e,:),lokvg(e,:)) = smb(lokvg(e,:),lokvg(e,:)) + emb;
  smc(lokvg(e,:),lokvg(e,:)) = smc(lokvg(e,:),lokvg(e,:)) + emc;
end;
for i=1:nnd, sma(ndp(i),ndp(i)) = ndv(i); end;
%----------------------------------------------------------------------
end;
%======================================================================
% Build the algebraic equation system
%======================================================================
%sumv = sumv0;
imflag = 1; dscintsys;                          % sm, rh <- dscintsys.m
%if mit>1, rh = rs; end;
%======================================================================
% Boundary conditions are taken into account
% Unknown nodal point values are solved
% Prescribed nodal values are inserted in the solution vector
%======================================================================
if npl>0, rh = rh - sm(:,plc) * lif'; end;
[sm,rh] = fbibpartit(1,sm,rh,ndof,pa,ppc,plc,prc,pe,lim);% fbibpartit.m

sol = inv(sm)*rh;

p = zeros(ndof,1); p(pu) = sol; p(ppc) = pe(ppc);
if npl>0, p(plc) = lim*p(prc) + lif'; end;

Tp = p;
%======================================================================
% Calculate derivatives
%======================================================================
imflag = 2; dscintsys;                        % Tdp,Tddp <- dscintsys.m
%======================================================================
%  Update element properties
%======================================================================
smc=zeros(ndof); smb=zeros(ndof); sma=zeros(ndof); 

for e=1:nel
  [eldaC] = dsc1elprop(e,eldaC,elda0,eldaB,lok,Tp);      % dsc1elprop.m
  updaelda;                                                % updaelda.m
  [ema,emb,emc] = dsc1elem(e,eldaC,elda0);                 % dsc1elem.m
  sma(lokvg(e,:),lokvg(e,:)) = sma(lokvg(e,:),lokvg(e,:)) + ema;
  smb(lokvg(e,:),lokvg(e,:)) = smb(lokvg(e,:),lokvg(e,:)) + emb;
  smc(lokvg(e,:),lokvg(e,:)) = smc(lokvg(e,:),lokvg(e,:)) + emc;
end;
for i=1:nnd, sma(ndp(i),ndp(i)) = ndv(i); end;
%======================================================================
%  Calculate residual force 
%======================================================================
if     im==1,    
  fi = sma*Tdp + smb*Tp + smc*sumv;
elseif (im==2 | im==3), 
  fi = sma*Tdp + smb*Tp + smc*diag(eye(length(Tp)));
%  fi = sma*Tdp + smb*Tp + smc*sumv;
%  dfi = sma*Tddp + smb*Tdp + smc*Tp;
end;
if im==1, rs = fe - fi; else rs = dfe - dfi; end;
%======================================================================
%  Update and store values
%======================================================================
eldaB = eldaC;
savefile = [matf num2str(ic)]; savedata;                   % savedata.m

pttt = ptt; ptt = pt; pt = p; dpt = dp; ddpt = ddp;
Tpttt = Tptt; Tptt = Tpt; Tpt = Tp; Tdpt = Tdp; Tddpt = Tddp;
fet = fe; dfet = dfe; Tpet = Tpe; 

ic = ic + 1;
disp(nic+1-ic)
save([matf '00'],'ic');

%----------------------------------------------------------------------
end; %ic

%**********************************************************************
