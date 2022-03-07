%**********************************************************************
%  disco2 : discrete system computation : 2-dimensional, nonlinear
%======================================================================
dsc2chkinp;                                              % dsc2chkinp.m
fbiblcase;                                                % fbiblcase.m
[Trm] = fbibtransbc(tr,ndof,nndof);                     % fbibtransbc.m
dsc2inizer;                                              % dsc2inizer.m
[elda0,eldaB,eldaC,mty5] = ...                           % dsc2inidat.m
                           dsc2inidat(nel,eldata,lok,crd0);     
save([matf num2str(0)]); 
crdB = crd0; crd = crd0;
%======================================================================
%  Incremental calculation
%======================================================================
ic = 1; ti = 0; ts2 = ts*ts; 

while ic<=nic, 
%----------------------------------------------------------------------
Tpe = zeros(ndof,1); Ipe = zeros(ndof,1); Dfe = zeros(ndof,1);
ti = ti + ts; 
loadincr; 
fe = feC; dfe = (2/ts)*(fe - fet) - dfet; 
if     li=='ip', Ipe = peC; Tpe = Tpet + Ipe; Dpe = Ipe;    
elseif li=='tp', Tpe = peC; Ipe = Tpe - Tpet; Dpe = Ipe; end;
if     mit==1, pe = Tpe; rs = fe;
elseif mit>1,  pe = Dpe; rs = fe - fi; end;
Dp = zeros(ndof,1); Ip = zeros(ndof,1); IpT = zeros(ndof,1);
%======================================================================
%  System matrices are assembled from element matrices
%  System matrices are transformed for local nodal coord.sys.
%======================================================================
if (ic==1 | nl==1)
%----------------------------------------------------------------------
smc=zeros(ndof); smb=zeros(ndof); sma=zeros(ndof); 

for e=1:nel,
  [emc,emcc,emb,efci,efbi] = dsc2elem(e,eldaC,elda0,1);    % dsc2elem.m
  smc(lokvg(e,:),lokvg(e,:)) = smc(lokvg(e,:),lokvg(e,:)) + emc;
  smb(lokvg(e,:),lokvg(e,:)) = smb(lokvg(e,:),lokvg(e,:)) + emb;
end;
for i=1:nma
  sma(2*map(i)-1,2*map(i)-1) = maw(i); 
  sma(2*map(i)  ,2*map(i)  ) = maw(i);
end;

if ntr>0
  smc=Trm'*smc*Trm; smb=Trm'*smb*Trm; sma=Trm'*sma*Trm;
end;

if ic==1, smc0=smc; end;

%----------------------------------------------------------------------
end;
%======================================================================
%  Iterative calculation
%======================================================================
nrm = 1000; it = 1;

while (nrm>ccr) & (it<=mit), 
%----------------------------------------------------------------------
%%%%%%%          smc=smc0;
%======================================================================
%  Build the algebraic equation system 
%======================================================================
imflag = 1; dscintsys;                          % sm, rh <- dscintsys.m
if mit>1, rh = rs; end; 
%======================================================================
%  Links and boundary conditions are taken into account
%  Unknown nodal point values are solved
%  Prescribed nodal values are inserted in the solution vector
%======================================================================
if npl>0, rh = rh - sm(:,plc) * lif'; end;
[sm,rh] = fbibpartit(it,sm,rh,ndof,pa,ppc,plc,prc,pe,lim);% fbibpartit.m

sol = inv(sm)*rh;

p = zeros(ndof,1); p(pu) = sol; if it==1, p(ppc) = pe(ppc); end;
if npl>0, p(plc) = lim*p(prc) + lif'; end;

if mit==1, Tp = p; else, Dp = p; Ip = Ip + Dp; Tp = Tp + Dp; end;
%======================================================================
%  Calculate derivatives
%======================================================================
imflag = 2; dscintsys;                        % Tdp,Tddp <- dscintsys.m
%======================================================================
%  Transformation dof's from local to global nodal coordinate systems
%======================================================================
if ntr>0, TpT = Trm * Tp; TdpT = Trm * Tdp; TddpT = Trm * Tddp;
else,     TpT = Tp; TdpT = Tdp; TddpT = Tddp; end;

crd = crd0 + reshape(TpT,nndof,nnod)';
%======================================================================
%  Update element properties
%======================================================================
smc=zeros(ndof); smb=zeros(ndof); 
fci=zeros(ndof,1);fbi=zeros(ndof,1); mty5=0;

for e=1:nel                                              % dsc2elprop.m
  [eldaC,mty5] = dsc2elprop(e,eldaC,elda0,eldaB,crd,lok,ts,mty5,eldax);
  updaelda;                                                % updaelda.m
  [emc,emcc,emb,efci,efbi] = dsc2elem(e,eldaC,elda0,2);    % dsc2elem.m
  smc(lokvg(e,:),lokvg(e,:)) = smc(lokvg(e,:),lokvg(e,:)) + emc;
  smb(lokvg(e,:),lokvg(e,:)) = smb(lokvg(e,:),lokvg(e,:)) + emb;
  fci(lokvg(e,:)) = fci(lokvg(e,:)) + efci;
  fbi(lokvg(e,:)) = fbi(lokvg(e,:)) + efbi;
end;
for i=1:nma
  sma(2*map(i)-1,2*map(i)-1) = maw(i); 
  sma(2*map(i)  ,2*map(i)  ) = maw(i);
end;

if ntr>0
  smc=Trm'*smc*Trm; smb=Trm'*smb*Trm; sma=Trm'*sma*Trm; 
  fci=Trm'*fci; fbi=Trm'*fbi;
end;
%======================================================================
%  Calculate residual force and convergence norm
%======================================================================
fai = sma*Tddp; 
fi = fai + fbi + fci;
rs = fe - fi;

nrm = fbibcnvnrm2(p,pt,rs,pu,1);                        % fbibcnvnrm2.m
if (it<=2), nrm=1000; end;

it = it + 1;
%----------------------------------------------------------------------
end; %it

%======================================================================
%  Transformation nodal forces from local to global nodal coord.sys.
%======================================================================
if ntr>0
  feT = Trm * fe; faT = Trm * fa; fbT = Trm * fb; fcT = Trm * fc;
  frT = Trm * fr; fiT = Trm * fi; ffT = Trm * ff; rsT = Trm * rs;
else
  feT = fe; faT = fa; fbT = fb; fcT = fc;
  frT = fr; fiT = fi; ffT = ff; rsT = rs;
end;
%======================================================================
%  Update and store values
%======================================================================
fbibcol2mat2;                                          % fbibcol2mat2.m
crdB = crd; eldaB = eldaC; 

% For special materials (11 and 33), the data are updated.
% mat = 11  : Lenard-Jones potential
% mat = 33  : cohesive zone for fatigue

[eldaB] = dsc2incend(eldaB,elda0,eldax,lok,crd,nel,ts,MTp,Mfi);% dsc2incend.m
eldaC = eldaB;

savefile = [matf num2str(ic)]; savedata;                   % savedata.m

ptt = pt; pt = p; dpt = dp; ddpt = ddp; 
Ipt = Ip;
Tptt = Tpt; Tpt = Tp; Tdpt = Tdp; Tddpt = Tddp; 
fet = fe; pet = pe; Tpet = Tpe;

ic = ic + 1;
disp(nic+1-ic)
save([matf '00'],'ic');

%----------------------------------------------------------------------
end; %ic

%**********************************************************************



